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
        text: "theme",
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
        {y: 297571, label: "Venezuela"},
        {y: 267017,  label: "Saudi" },
        {y: 175200,  label: "Canada"},
        {y: 154580,  label: "Iran"},
        {y: 116000,  label: "Russia"},
        {y: 97800, label: "UAE"},
        {y: 20682,  label: "US"},
        {y: 20350,  label: "China"},
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