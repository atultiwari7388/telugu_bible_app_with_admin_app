// import 'package:flutter/material.dart';
// import 'package:mylex_practical/constants/utils/colors.utils.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class AdminLinearChartWidget extends StatefulWidget {
//   const AdminLinearChartWidget({Key? key}) : super(key: key);

//   @override
//   State<AdminLinearChartWidget> createState() => _AdminLinearChartWidgetState();
// }

// class _AdminLinearChartWidgetState extends State<AdminLinearChartWidget> {
//   List<_SalesData> data = [
//     _SalesData('Jan', 35, AppColors.kPrimaryColor),
//     _SalesData('Feb', 28, AppColors.kRedColor),
//     _SalesData('Mar', 34, Colors.blue),
//     _SalesData('Apr', 32, Colors.green),
//     _SalesData('May', 18, Colors.yellow),
//     _SalesData('Jun', 76, Colors.orange),
//     _SalesData('Jul', 55, Colors.tealAccent),
//     _SalesData('Aug', 49, Colors.redAccent),
//     _SalesData('Sep', 23, Colors.orangeAccent),
//     _SalesData('Oct', 25, Colors.indigoAccent),
//     _SalesData('Nov', 89, Colors.purpleAccent),
//     _SalesData('Dec', 75, Colors.red),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       child: Column(
//         children: [
//           //Initialize the chart widget
//           SfCartesianChart(
//             primaryXAxis: CategoryAxis(),
//             // Chart title
//             title: ChartTitle(text: 'Yearly dummy sales analysis'),
//             // Enable legend
//             legend: Legend(isVisible: true),
//             // Enable tooltip
//             tooltipBehavior: TooltipBehavior(enable: true),
//             series: <ChartSeries<_SalesData, String>>[
//               SplineSeries<_SalesData, String>(
//                 // dashArray: [25, 5],
//                 dataSource: data,
//                 xValueMapper: (_SalesData sales, _) => sales.year,
//                 yValueMapper: (_SalesData sales, _) => sales.sales,
//                 name: 'Sales',
//                 // Enable data label
//                 dataLabelSettings: const DataLabelSettings(
//                     isVisible: true, color: AppColors.kPrimaryColor),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(this.year, this.sales, this.color);

//   final String year;
//   final double sales;
//   final Color color;
// }
