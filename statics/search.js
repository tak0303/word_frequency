function highlight(query){
    var span = document.createElement('span');
    span.setAttribute('class','highlight');
    span.style.backgroundColor='yellow';
    span.style.color='black';
    var textElem = document.getElementById('text');
    var text     = textElem.innerText;
    var result = wrapText(query,span,text);
    h = document.getElementById('hoge');
    console.log(result)
    h.appendChild(result);
}

function wrapText(query,span,text){
    var result = document.createElement('p');
    result.innerHtml = '';
    while (1) {
        var len      = query.length;
        var start    = +text.toLowerCase().indexOf(query);
        if(start < 0){
          break;
        }
        var end      = +start + len;
        var queryText = document.createTextNode(text.substr(start,len+1));
        if(span.innerText.length){
          span.innerText = '';
        }
        span.appendChild(queryText);
        var before = text.substr(0,start);
        var after  = text.substr(end);
        // result.innerHtml += before;
        r += span
        // result.appendChild(span);
        text = after
    };
    console.log(r)
    result.appendChild(r);
    return result;
}