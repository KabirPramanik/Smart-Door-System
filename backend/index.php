<!DOCTYPE html>
<html lang="en">


<?php

include("./db_conn.php");

?>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Dashboard Admin Template by Tooplate.com</title>
<!--

Template 2108 Dashboard

http://www.tooplate.com/view/2108-dashboard

-->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600">
<!-- https://fonts.google.com/specimen/Open+Sans -->
<link rel="stylesheet" href="css/fontawesome.min.css">
<!-- https://fontawesome.com/ -->
<link rel="stylesheet" href="css/fullcalendar.min.css">
<!-- https://fullcalendar.io/ -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- https://getbootstrap.com/ -->
<link rel="stylesheet" href="css/tooplate.css">
</head>

<body id="reportsPage">
<div class="" id="home">
    <div class="container">
        <!-- row -->
        <div class="row tm-content-row tm-mt-big">
            <div class="tm-col tm-col-big">
                <div class="bg-white tm-block h-100">
                    <h2 class="tm-block-title">Latest Hits</h2>
                    <canvas id="lineChart"></canvas>
                </div>
            </div>
            <div style="visibility: hidden;" class="tm-col tm-col-big">
                <div class="bg-white tm-block h-100">
                    <h2 class="tm-block-title">Performance</h2>
                    <canvas id="barChart"></canvas>
                </div>
            </div>
            <div style="visibility: hidden;" class="tm-col tm-col-small">
                <div class="bg-white tm-block h-100">
                    <canvas id="pieChart" class="chartjs-render-monitor"></canvas>
                </div>
            </div>

        </div>
        <div class="row tm-content-row tm-mt-big">
            <div class="bg-white tm-block h-100">

                <table class="table table-hover table-striped tm-table-striped-even mt-3">
                    <thead>
                        <tr class="tm-bg-gray">
                            <th scope="col">Name</th>
                            <th scope="col" class="text-center">Entry Time</th>
                            <th scope="col" class="text-center">Exit Time</th>
                            <th scope="col">timimg...</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                            $sql  = $conn->query("SELECT * FROM `gate_auth` ORDER BY `id` DESC ");
                            while ($row = $sql->fetch_assoc()) {
                                // print_r($row);
                                $openT =$row["gate_open_time"];
                                $closeT =$row["exit_time"];
                                $openT = $openT / 1000;
                                $closeT = $closeT / 1000;
                                $timeO =  date("Y-m-d H:i:s", $openT);
                                $timeC =  date("Y-m-d H:i:s", $closeT);
                                
                                if($row["status"] == "create"){
                                    continue;
                                }
                                
                                if($row["status"] != "ex-close"){
                                    $timeC = "In the room...";
                                    $timecal = "Not available...";
                                }else{
                                    $timecal = (string) (($row["exit_time"]-$row["gate_open_time"])/1000) ;
                                    $timecal = round( $timecal)." S";

                                }
                                ?>

<tr>
                           
                            <td class="tm-product-name"><?php echo $row["gate_open_by"]; ?> </td>
                            <td class="text-center"><?php echo $timeO; ?> </td>
                            <td class="text-center"><?php echo $timeC; ?> </td>
                            <td><?php echo $timecal; ?></td>
                        </tr>
<?php
                            }

                        ?>
                        

                    </tbody>
                </table>


            </div>


        </div>
    </div>
</div>
<script src="js/jquery-3.3.1.min.js"></script>
<!-- https://jquery.com/download/ -->
<script src="js/moment.min.js"></script>
<!-- https://momentjs.com/ -->
<script src="js/utils.js"></script>
<script src="js/Chart.min.js"></script>
<!-- http://www.chartjs.org/docs/latest/ -->
<script src="js/fullcalendar.min.js"></script>
<!-- https://fullcalendar.io/ -->
<script src="js/bootstrap.min.js"></script>
<!-- https://getbootstrap.com/ -->
<script src="js/tooplate-scripts.js"></script>
<script>
    let ctxLine,
        ctxBar,
        ctxPie,
        optionsLine,
        optionsBar,
        optionsPie,
        configLine,
        configBar,
        configPie,
        lineChart;
    barChart, pieChart;
    // DOM is ready
    $(function() {
        updateChartOptions();
        drawLineChart(); // Line Chart
        drawBarChart(); // Bar Chart
        drawPieChart(); // Pie Chart
        drawCalendar(); // Calendar

        $(window).resize(function() {
            updateChartOptions();
            updateLineChart();
            updateBarChart();
            reloadPage();
        });
    })
</script>
</body>

</html>