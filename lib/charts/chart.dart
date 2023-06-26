// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;


// class Flutterchart extends StatefulWidget {
//   const Flutterchart({Key? key}) : super(key: key);

//   @override
//   _State createState() => _State();
// }

// class Sales {
//   String year;
//   int sales;
//   Sales(this.year, this.sales);
// }

// class _State extends State<Flutterchart> {
//   late List<Sales> _data;
//   late List<charts.Series<Sales, String>> _chartdata;
//   void makeData() {
//     _data = <Sales>[];
//     _chartdata = <charts.Series<Sales, String>>[];
//     final rnd = Random();
//     for (int i = 2020; i < 2023; i++) {
//       _data.add(Sales(i.toString(), rnd.nextInt(1000)));
//     }
//     _chartdata.add(charts.Series(
//       id: 'Sales'
//           '',
//       data: _data,
//       domainFn: (Sales sales, __) => sales.year,
//       measureFn: (Sales sales, __) => sales.sales,
//       seriesColor: charts.ColorUtil.fromDartColor(const Color(0xffFFA500)),
//       // colorFn: (Sales sales,__)=>charts.MaterialPalette.black,
//       fillPatternFn: (Sales sales, __) => charts.FillPatternType.forwardHatch,
//       displayName: 'sales',
//     ));
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     makeData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: Colors.blue,
//       // width: 1000,
//       // padding: new EdgeInsets.all(32.0),
//       child: Row(
//         children: <Widget>[
//           Expanded(child: charts.BarChart(_chartdata)),
//         ],
//       ),
//     );
//   }
// }
