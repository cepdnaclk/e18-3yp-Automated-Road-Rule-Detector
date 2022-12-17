import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class vehicle_analyze extends StatefulWidget {
  static const String id = 'vehcile_analyze';

  @override
  State<vehicle_analyze> createState() => _vehicle_analyzeState();
}

class _vehicle_analyzeState extends State<vehicle_analyze> {
  late List<Breakages> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.indigo.shade200,
                Colors.deepOrange.shade200,
              ],
            ),
          ),
          child: SfCartesianChart(
            title: ChartTitle(text: 'Vehicle Data Analysis'),
            legend: Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries<Breakages, DateTime>>[
              LineSeries<Breakages, DateTime>(
                  name: 'Breakages',
                  dataSource: _chartData,
                  xValueMapper: (Breakages sales, _) => sales.date,
                  yValueMapper: (Breakages sales, _) => sales.p_value,
                  enableTooltip: true)
            ],
            //primaryXAxis: DateTimeAxis(), //DateTimeAxis ->Axis type
            primaryXAxis: DateTimeAxis(
                title: AxisTitle(
                    text: 'Date',
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      // fontStyle: FontStyle.italic,
                      // fontWeight: FontWeight.w300
                    ))),
            // primaryYAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
            primaryYAxis: NumericAxis(
                title: AxisTitle(
                    text: 'Severity',
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      // fontStyle: FontStyle.italic,
                      // fontWeight: FontWeight.w300
                    ))),
          ),
        ),
      ),
    );
  }

  List<Breakages> getChartData() {
    final List<Breakages> chartData = [
      Breakages(DateTime(2022, 1, 1), 6),
      Breakages(DateTime(2022, 2), 11),
      Breakages(DateTime(2022, 3, 15), 9),
      Breakages(DateTime(2022, 4), 14),
      Breakages(DateTime(2022, 5, 1), 10),
    ];
    return chartData;
  }
}

class Breakages {
  Breakages(this.date, this.p_value);
  final DateTime date;
  final double p_value;
}
