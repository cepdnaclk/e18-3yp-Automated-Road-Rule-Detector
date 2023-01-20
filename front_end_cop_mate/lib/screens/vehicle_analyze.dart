import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_end_cop_mate/elements/ReusableCard.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:front_end_cop_mate/models/Vehicle.dart';
import 'package:front_end_cop_mate/screens/one_breaking.dart';
import 'package:front_end_cop_mate/screens/search_vehicles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:front_end_cop_mate/models/Vehicle.dart';
import 'package:front_end_cop_mate/models/Breaking.dart';
import 'package:front_end_cop_mate/bottomnavgationbar.dart';
import 'package:http/http.dart' as http;

class vehicle_analyze extends StatefulWidget {
  static const String id = 'vehcile_analyze';
  final Vehicle vehicle;

  const vehicle_analyze({
    required this.vehicle,
  });
  @override
  State<vehicle_analyze> createState() => _vehicle_analyzeState();
}

List<Breaking> breakings = [];

class _vehicle_analyzeState extends State<vehicle_analyze> {
  late List<Breakages> _chartData;
  late TooltipBehavior _tooltipBehavior;
  bool _isShown = true;

  // List<Breaking> breakings = [
  //   const Breaking(
  //       vehiclenumber: "CBL 8999",
  //       breakingnumber: "72578",
  //       pvalue: "10",
  //       type: "0771515145",
  //       location: "0771515145",
  //       distance: "0771515145",
  //       dateandtime: "0771515145"),
  //   const Breaking(
  //       vehiclenumber: "CBL 8999",
  //       breakingnumber: "5423",
  //       pvalue: "10",
  //       type: "0771515145",
  //       location: "0771515145",
  //       distance: "0771515145",
  //       dateandtime: "0771515145"),
  //   const Breaking(
  //       vehiclenumber: "CBL 8999",
  //       breakingnumber: "5643",
  //       pvalue: "10",
  //       type: "0771515145",
  //       location: "0771515145",
  //       distance: "0771515145",
  //       dateandtime: "0771515145"),
  //   const Breaking(
  //       vehiclenumber: "CBL 8999",
  //       breakingnumber: "533",
  //       pvalue: "10",
  //       type: "0771515145",
  //       location: "0771515145",
  //       distance: "0771515145",
  //       dateandtime: "0771515145"),
  //   const Breaking(
  //       vehiclenumber: "CBL 8999",
  //       breakingnumber: "4523456",
  //       pvalue: "10",
  //       type: "0771515145",
  //       location: "0771515145",
  //       distance: "0771515145",
  //       dateandtime: "0771515145"),
  // ];

  List<Breaking> breakingsDup = [];

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    filterSearchResults("");
  }

  void filterSearchResults(String query) {
    breakings = widget.vehicle.breakings;
    _chartData = getChartData();
    List<Breaking> dummySearchList = [];
    dummySearchList.addAll(breakings);
    if (query != "") {
      List<Breaking> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.dateandtime.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        breakingsDup.clear();
        breakingsDup.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        breakingsDup.clear();
        breakingsDup.addAll(breakings);
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cop Mate'),
        leading: null,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => bottomnavigationbar()),
                    (r) => false);
              },
              icon: Icon(Icons.home))
        ],
        backgroundColor: Color(0xFF518BB8),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                heading(
                    string: "Vehicle No.  " + widget.vehicle.vehiclenumber,
                    icon: FontAwesomeIcons.car,
                    space: 20),
                Container(
                  padding: EdgeInsets.all(10.0),
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
                      SizedBox(height: 10),
                      ReusableCard(string: "Owner:    " + widget.vehicle.name),
                      SizedBox(height: 3),
                      ReusableCard(
                          string: "Contact:    " + widget.vehicle.telephone),
                      SizedBox(height: 3),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white54,
                        ),
                        height: 60,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text("Email:  " + widget.vehicle.email,
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete this Vehicle?'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                              'Would you like to delete this Vehicle?'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Confirm'),
                                        onPressed: () async {
                                          print('Confirmed');
                                          String url =
                                              "https://us-central1-cop-mate.cloudfunctions.net/deleteVehicle?licenseplatenumber=" +
                                                  widget.vehicle.vehiclenumber;
                                          final response2 =
                                              await http.delete(Uri.parse(url));

                                          if (response2.statusCode == 200) {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        bottomnavigationbar()),
                                                (r) => false);
                                          }
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Colors.redAccent,
                                ),
                                minimumSize: MaterialStatePropertyAll<Size>(
                                    Size(150, 50))),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      ReusableCard(string: "Breakings"),
                      SizedBox(height: 10),
                      Container(
                        height: 500,
                        width: 400,
                        child: SfCartesianChart(
                          backgroundColor: Colors.white,
                          legend: Legend(isVisible: true),
                          tooltipBehavior: _tooltipBehavior,
                          series: <ChartSeries<Breakages, DateTime>>[
                            LineSeries<Breakages, DateTime>(
                                name: 'Breakages',
                                dataSource: _chartData,
                                sortingOrder: SortingOrder.ascending,
                                sortFieldValueMapper: (Breakages sales, _) =>
                                    sales.date,
                                xValueMapper: (Breakages sales, _) =>
                                    sales.date,
                                yValueMapper: (Breakages sales, _) =>
                                    sales.p_value,
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
                      SizedBox(height: 20),
                      ReusableCard(string: "Search for Breaking"),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Search",
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        height: 500,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: breakingsDup.length,
                          itemBuilder: (context, index) {
                            final breaking = breakingsDup[index];
                            return Card(
                              child: ListTile(
                                title: Text("Date: " + breaking.dateandtime),
                                subtitle: Text("P value " + breaking.pvalue),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => one_breaking(
                                            breaking: breaking,
                                          )));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Breakages> getChartData() {
  final List<Breakages> chartData = [
    // Breakages(DateTime(2022, 1, 1), 6, 545),
    // Breakages(DateTime(2022, 2), 11, 54151),
    // Breakages(DateTime(2022, 3, 15), 9, 4),
  ];

  breakings.forEach((element) {
    chartData.add(Breakages(DateTime.parse(element.dateandtime),
        double.parse(element.pvalue), element.breakingnumber));
  });
  return chartData;
}

class Breakages {
  Breakages(this.date, this.p_value, this.breakingnumber);
  final breakingnumber;
  final DateTime date;
  final double p_value;
}

class chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
