<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <link rel="stylesheet" href="/static/style.css">
  <script src='/static/search.js'></script>
  <script src='/static/canvasjs.min.js'></script>
</head>
<body>
  <header>
    <div class="header_wrap">
      <div class="title">Software Engineering</div>
    </div>
  </header>
  %if data:
  <div id="chartContainer" style="height: 300px; width: 100%;margin-top:60px;"></div>
  <div id="text">{{text}}</div>
  <div id="hoge"></div>
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
      theme: "theme4",
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
        ],
        click:function(e){
          searchText(e.dataPoint.y)
        }
      }
      ]
    });
    chart.render();
  }
  </script>
  %end
</body>
</html>