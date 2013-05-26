<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>test</title>
</head>

<body>
  <form action="/upload" method="post" enctype="multipart/form-data">
    <input type="file" name="file" id="file">
    <input type="submit" value="submit">
    <select name="category">
      % i = 0
      %for n in category:
        <option value="{{category[i][0]}}">{{category[i][1]}}</option>
        % i += 1
      %end
    </select>
  </form>
</body>
</html>