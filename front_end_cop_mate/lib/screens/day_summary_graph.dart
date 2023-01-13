import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

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
    _chartData = getChartDataFirst();
    super.initState();
    getChartDataSecond();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF234E70),
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              heading(
                  string: "Day Summary",
                  icon: FontAwesomeIcons.calendarDay,
                  space: 20),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 600,
                      width: 400,
                      child: SfCartesianChart(
                        legend: Legend(isVisible: true),
                        backgroundColor: Colors.white70,
                        series: <ChartSeries<ChartData, DateTime>>[
                          ColumnSeries<ChartData, DateTime>(
                              name: 'Dash',
                              color: Color(0xFFa9a9a9),
                              dataSource: _chartData,
                              xValueMapper: (ChartData data, _) => data.date,
                              yValueMapper: (ChartData data, _) =>
                                  data.singleLine),
                          // LineSeries<ChartData, DateTime>(
                          //     name: 'Breakages',
                          //     dataSource: _chartData,
                          //     xValueMapper: (ChartData sales, _) => sales.date,
                          //     yValueMapper: (ChartData sales, _) => sales.p_value,
                          //     enableTooltip: true)
                          ColumnSeries<ChartData, DateTime>(
                              name: 'Single Line',
                              color: Color(0xFF878787),
                              dataSource: _chartData,
                              xValueMapper: (ChartData data, _) => data.date,
                              yValueMapper: (ChartData data, _) =>
                                  data.doubleLine),
                          ColumnSeries<ChartData, DateTime>(
                              name: 'Double Line',
                              color: Color(0xFF555555),
                              dataSource: _chartData,
                              xValueMapper: (ChartData data, _) => data.date,
                              yValueMapper: (ChartData data, _) =>
                                  data.crossingLine)
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
                        palette: <Color>[
                          Colors.purple,
                          Colors.blueGrey,
                          Colors.red
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ChartData> getChartDataFirst() {
    var now = DateTime.now();

    final List<ChartData> chartData = [
      ChartData(DateTime(now.year, now.month, now.day, 2), 0, 0, 0),
      ChartData(DateTime(now.year, now.month, now.day, 6), 0, 0, 0),
      ChartData(DateTime(now.year, now.month, now.day, 10), 0, 0, 0),
      ChartData(DateTime(now.year, now.month, now.day, 14), 0, 0, 0),
      ChartData(DateTime(now.year, now.month, now.day, 18), 0, 0, 0),
      ChartData(DateTime(now.year, now.month, now.day, 22), 0, 0, 0),
    ];
    return chartData;
  }

  void getChartDataSecond() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    String urlbreakings =
        "https://us-central1-cop-mate.cloudfunctions.net/getFrequency?date=" +
            formattedDate;
    final List<ChartData> chartData;
    final response = await http.get(Uri.parse(urlbreakings));
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      chartData = [
        ChartData(
          DateTime(now.year, now.month, now.day, 2),
          decodeData[0]['dash'] + .0,
          decodeData[0]['single'] + .0,
          decodeData[0]['double'] + .0,
        ),
        ChartData(
          DateTime(now.year, now.month, now.day, 6),
          decodeData[1]['dash'] + .0,
          decodeData[1]['single'] + .0,
          decodeData[1]['double'] + .0,
        ),
        ChartData(
          DateTime(now.year, now.month, now.day, 10),
          decodeData[2]['dash'] + .0,
          decodeData[2]['single'] + .0,
          decodeData[2]['double'] + .0,
        ),
        ChartData(
          DateTime(now.year, now.month, now.day, 14),
          decodeData[3]['dash'] + .0,
          decodeData[3]['single'] + .0,
          decodeData[3]['double'] + .0,
        ),
        ChartData(
          DateTime(now.year, now.month, now.day, 18),
          decodeData[4]['dash'] + .0,
          decodeData[4]['single'] + .0,
          decodeData[4]['double'] + .0,
        ),
        ChartData(
          DateTime(now.year, now.month, now.day, 22),
          decodeData[5]['dash'] + .0,
          decodeData[5]['single'] + .0,
          decodeData[5]['double'] + .0,
        ),
      ];

      _chartData = chartData;
      setState(() {
        print("Set");
      });
    }
  }
}

class ChartData {
  ChartData(this.date, this.singleLine, this.doubleLine, this.crossingLine);
  final DateTime date;
  final double singleLine;
  final double doubleLine;
  final double crossingLine;
}
