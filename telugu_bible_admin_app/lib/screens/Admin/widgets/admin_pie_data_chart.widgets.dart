// import 'package:flutter/material.dart';

// class AdminPieDataChart extends StatefulWidget {
//   const AdminPieDataChart({Key? key}) : super(key: key);

//   @override
//   State<AdminPieDataChart> createState() => _AdminPieDataChartState();
// }

// class _AdminPieDataChartState extends State<AdminPieDataChart> {
//   List<_SalesData> data = [
//     _SalesData('Monday', 35),
//     _SalesData('Tuesday', 28),
//     _SalesData('Wednesday', 34),
//     _SalesData('Thursday', 32),
//     _SalesData('Friday', 18),
//     _SalesData('Saturday', 76),
//     _SalesData('Sunday', 55),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SfCircularChart(
//         legend: Legend(isVisible: true),
//         title: ChartTitle(text: 'Weekly dummy sales analysis'),
//         series: [
//           PieSeries<_SalesData, String>(
//               radius: "140",
//               dataSource: data,
//               explode: true,
//               explodeIndex: 0,
//               xValueMapper: (_SalesData sales, _) => sales.week,
//               yValueMapper: (_SalesData sales, _) => sales.sales,
//               dataLabelSettings: const DataLabelSettings(isVisible: true)),
//         ],
//       ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(this.week, this.sales);

//   final String week;
//   final double sales;
// }
