<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>MonoGraphY</title>
  <link rel="stylesheet" href="/static/style.css">
</head>

<body>
  <header>
    <div class="header_wrap">
      <div class="title">MonoGraphY</div>
    </div>
  </header>
  <form action="/upload" method="post" enctype="multipart/form-data">
    <div class="form_wrapper">
      <input type="file" name="file" id="file">
      <select name="category">
        % i = 0
        %for n in category:
          <option value="{{category[i][0]}}">{{category[i][1]}}</option>
          % i += 1
        %end
      </select>
      <input type="submit" value="submit">
    </div>
  </form>
</body>
</html>