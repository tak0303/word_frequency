import MySQLdb
import pyPdf
import os
import nltk
import MySQLdb
from bottle import route, run, template, request, static_file

############### routing starts here


@route('/')
def index(name='World'):
    category = get_all_data('category')
    return template('index', name=name, category=category)


@route('/upload', method='POST')
def upload():
    data = request.files.get('file')
    category_id = request.forms.get('category')
    name, ext = os.path.splitext(data.filename)
    if ext != '.pdf':
        return 'File extension not allowed.'
    fdist, text = get_word_frequency(pyPdf.PdfFileReader(data.file), data, category_id)
    return template('show', data=fdist, text=text)


@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='./statics/')


############### functions starts here


def get_word_frequency(pdf, data, category_id):
    pdf = pyPdf.PdfFileReader(data.file)
    raw_text = ""
    for page in pdf.pages:
        raw_text += page.extractText() + "\n"
    raw_text = " ".join(raw_text.replace(u"\xa0", " ").strip().split())

    tokens = nltk.word_tokenize(raw_text)
    text = nltk.Text(tokens)

    stopwords = nltk.corpus.stopwords.words('english')
    symbols = ["'", '"', '`', '.', ',', '-', '!', '?', ':', ';', '(', ')']
    fdist = nltk.FreqDist(w.lower() for w in text if w.lower() not in stopwords + symbols)

    insert_freq_data(fdist, raw_text, category_id)

    return fdist, raw_text


def insert_freq_data(fdist, raw_text, category_id):
    connect = connect_to_db()
    cur = connect.cursor()
    cur.execute(
        'INSERT INTO papers'
        '(body, category_id)'
        'VALUES(%s, %s)',
        (raw_text, category_id)
    )
    cur.close()
    connect.close()


def get_all_data(table):
    connect = connect_to_db()
    cur = connect.cursor()
    cur.execute('SELECT * FROM ' + table)
    data = cur.fetchall()
    cur.close
    connect.close()
    return data


def connect_to_db():
    connect = MySQLdb.connect(
        db="software_class",
        host="localhost",
        port=3306,
        user="root",
        passwd=""
    )
    return connect

# run the server
run(host='localhost', port=8080, debug=True, reloader=True)
