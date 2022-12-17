import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: day_summary_graph(),
    );
  }
}

class day_summary_graph extends StatefulWidget {
  day_summary_graph({Key? key}) : super(key: key);
  static const String id = 'day_summary_graph';
  @override
  _day_summary_graphState createState() => _day_summary_graphState();
}

class _day_summary_graphState extends State<day_summary_graph> {
  late List<ChartData> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          title: ChartTitle(text: 'Day summary graph'),
          legend: Legend(isVisible: true),
          series: <ChartSeries<ChartData, DateTime>>[
            ColumnSeries<ChartData, DateTime>(
                name: 'Single Line',
                dataSource: _chartData,
                xValueMapper: (ChartData data, _) => data.date,
                yValueMapper: (ChartData data, _) => data.singleLine),
            // LineSeries<ChartData, DateTime>(
            //     name: 'Breakages',
            //     dataSource: _chartData,
            //     xValueMapper: (ChartData sales, _) => sales.date,
            //     yValueMapper: (ChartData sales, _) => sales.p_value,
            //     enableTooltip: true)
            ColumnSeries<ChartData, DateTime>(
                name: 'Double Line',
                dataSource: _chartData,
                xValueMapper: (ChartData data, _) => data.date,
                yValueMapper: (ChartData data, _) => data.doubleLine),
            ColumnSeries<ChartData, DateTime>(
                name: 'Crossing Line',
                dataSource: _chartData,
                xValueMapper: (ChartData data, _) => data.date,
                yValueMapper: (ChartData data, _) => data.crossingLine)
          ],
          //primaryXAxis: DateTimeAxis(), //DateTimeAxis ->Axis type
          primaryXAxis: DateTimeAxis(
              intervalType: DateTimeIntervalType.hours,
              interval: 4,
              title: AxisTitle(
                  text: 'Hours',
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
                  text: 'Frequency',
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    // fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.w300
                  ))),
          palette: <Color>[Colors.purple, Colors.blueGrey, Colors.red],
        ),
      ),
    );
  }

  List<ChartData> getChartData() {
    final List<ChartData> chartData = [
      ChartData(DateTime(2022, 12, 1, 1, 20), 26, 12, 18),
      ChartData(DateTime(2022, 12, 1, 6, 20), 51, 25, 6),
      ChartData(DateTime(2022, 12, 1, 10, 20), 29, 22, 9),
      ChartData(DateTime(2022, 12, 1, 15, 20), 34, 23, 22),
      ChartData(DateTime(2022, 12, 1, 21, 20), 60, 15, 25),
    ];
    return chartData;
  }
}

class ChartData {
  ChartData(this.date, this.singleLine, this.doubleLine, this.crossingLine);
  final DateTime date;
  final double singleLine;
  final double doubleLine;
  final double crossingLine;
}
