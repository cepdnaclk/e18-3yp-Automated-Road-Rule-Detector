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
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                            text: 'Hours',
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              // fontStyle: FontStyle.italic,
                              // fontWeight: FontWeight.w300
                            ))),
                    primaryYAxis: CategoryAxis(
                        title: AxisTitle(
                            text: 'Frequency',
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              // fontStyle: FontStyle.italic,
                              // fontWeight: FontWeight.w300
                            ))),
                    palette: <Color>[
                      Colors.purple,
                      Colors.blueGrey,
                      Colors.red
                    ],
                    series: <CartesianSeries>[
                      ColumnSeries<ChartData, String>(
                          dataSource: _chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.singleLine),
                      ColumnSeries<ChartData, String>(
                          dataSource: _chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.doubleLine),
                      ColumnSeries<ChartData, String>(
                          dataSource: _chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.crossingLine)
                    ]))));
  }

  List<ChartData> getChartData() {
    final List<ChartData> chartData = <ChartData>[
      ChartData('0-4', 128, 129, 101),
      ChartData('4-8', 123, 92, 93),
      ChartData('8-12', 107, 106, 90),
      ChartData('12-16', 87, 95, 71),
      ChartData('16-20', 87, 95, 71),
      ChartData('20-24', 87, 95, 71),
    ];
    return chartData;
  }
}

class ChartData {
  ChartData(this.x, this.singleLine, this.doubleLine, this.crossingLine);
  final String x;
  final double singleLine;
  final double doubleLine;
  final double crossingLine;
}
