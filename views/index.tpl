<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>test</title>
  <script src='/static/canvasjs.min.js'></script>
</head>

<body>
  <form action="/upload" method="post" enctype="multipart/form-data">
    <input type="file" name="piyo" id="piyo">
    <input type="submit" value="hoge">
  </form>
  %if data:
  <div id="chartContainer" style="height: 300px; width: 100%;">
  <script type="text/javascript">
  window.onload = function () {
    var chart = new CanvasJS.Chart("chartContainer",
    {
      title:{
        text: "word frequency in paper",
      },
      axisY: {
        title: "frequency(times)"
      },
      legend: {
        verticalAlign: "bottom",
        horizontalAlign: "center"
      },
      theme: "theme2",
      data: [

      {
        type: "column",
        showInLegend: true,
        legendMarkerColor: "grey",
        legendText: "words",
        dataPoints: [
        % i = 0
        %for key in data:
          %if i == 50:
            % break
          %end
          {y: {{data[key]}}, label: "{{key}}" },
          % i += 1
        %end
        ]
      },
      ]
    });
    chart.render();
  }
  </script>
  %end
</body>
</html>