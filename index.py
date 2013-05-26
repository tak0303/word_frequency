import MySQLdb
import pyPdf
import os
import nltk
from bottle import route, run, template, request, static_file

############### routing starts here


@route('/')
def index(name='World'):
    category = get_all_data('category')
    return template('index', name=name, category=category)


@route('/upload', method='POST')
def upload():
    data = request.files.get('file')
    name, ext = os.path.splitext(data.filename)
    if ext != '.pdf':
        return 'File extension not allowed.'
    fdist, text = get_word_frequency(pyPdf.PdfFileReader(data.file), data)
    return template('show', data=fdist, text=text)


@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='./statics/')


############### functions starts here


def get_word_frequency(pdf, data):
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
    return fdist, raw_text


def get_all_data(table):
    connect = MySQLdb.connect(
        db="software_class",
        host="localhost",
        port=3306,
        user="root",
        passwd="bukyoku"
    )
    cur = connect.cursor()
    cur.execute('SELECT * FROM ' + table)
    data = cur.fetchall()
    cur.close
    connect.close()
    return data

# run the server
run(host='localhost', port=8080, debug=True, reloader=True)
