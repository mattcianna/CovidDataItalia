import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid/models/daily_recap.dart';
import 'package:flutter/material.dart';

class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {this.animate});

  factory DonutAutoLabelChart.withData(List<DailyRecap> recaps) {
    return new DonutAutoLabelChart(
      _createData(recaps),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList, animate: animate);
  }

  static List<charts.Series<PieChartData, String>> _createData(
      List<DailyRecap> recaps) {
    final data = recaps.map((e) {
      return PieChartData(e.denominazioneRegione, e.totaleCasi);
    }).toList();

    return [
      new charts.Series<PieChartData, String>(
        id: 'Cases',
        domainFn: (PieChartData cases, _) => cases.region,
        measureFn: (PieChartData cases, _) => cases.cases,
        data: data,
        labelAccessorFn: (PieChartData row, _) => '${row.region}: ${row.cases}',
      )
    ];
  }
}

class PieChartData {
  final String region;
  final int cases;

  PieChartData(this.region, this.cases);
}
