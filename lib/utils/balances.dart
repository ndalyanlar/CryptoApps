import 'package:crypto_dashboard/Icons/my_flutter_app_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData> balances(int? touchedIndex) {
  return List.generate(4, (i) {
    final isTouched = i == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 60.0 : 50.0;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xff0293ee),
          value: 30,
          title: 'ETH',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xfff8b250),
          value: 30,
          title: 'BTC',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: const Color(0xff845bef),
          value: 15,
          title: 'BTT',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 3:
        return PieChartSectionData(
          color: const Color(0xff0100aa),
          value: 25,
          title: 'XRP',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      default:
        throw Error();
    }
  });
}

// final fontSize = 25.0;
// final radius = 60.0;
// List<PieChartSectionData> balancesTest = [
//   PieChartSectionData(
//     color: const Color(0xff0293ee),
//     value: 20,
//     title: 'ETH',
//     radius: radius,
//     titleStyle: TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.bold,
//         color: const Color(0xffffffff)),
//   ),
//   PieChartSectionData(
//     color: const Color(0xfff8b250),
//     value: 80,
//     title: 'BTC',
//     radius: radius,
//     titleStyle: TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.bold,
//         color: const Color(0xffffffff)),
//   ),
//   PieChartSectionData(
//     color: const Color(0xff845bef),
//     value: 10,
//     title: 'BTT',
//     radius: radius,
//     titleStyle: TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.bold,
//         color: const Color(0xffffffff)),
//   ),
//   PieChartSectionData(
//     color: const Color(0xff0100aa),
//     value: 20,
//     title: 'XRP',
//     radius: radius,
//     titleStyle: TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.bold,
//         color: const Color(0xffffffff)),
//   ),
// ];
