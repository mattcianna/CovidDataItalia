/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid/models/daily_recap.dart';
import 'package:covid/providers/daily_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineChartWidget extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  LineChartWidget(this.seriesList, {this.animate});

  factory LineChartWidget.withVariationData(DailyProvider provider) {
    return new LineChartWidget(
      _createVariationData(provider),
      animate: true,
    );
  }

  factory LineChartWidget.withTotalData(DailyProvider provider) {
    return new LineChartWidget(
      _createTotalData(provider),
      animate: true,
    );
  }

  static List<charts.Series<LineChartData, DateTime>> _createVariationData(
      DailyProvider provider) {
    final recaps = provider.lastRecaps;

    final positiveData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.variazioneTotalePositivi);
    }).toList();

    final newPositiveData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.nuoviPositivi);
    }).toList();

    final deathData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.nuoviDeceduti);
    }).toList();

    final recoveredData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.nuoviGuariti);
    }).toList();

    final hospData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.variazioneOspedalizzati);
    }).toList();

    final tiData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.variazioneTerapiaIntensiva);
    }).toList();

    final List<charts.Series<LineChartData, DateTime>> toReturn = [];
    if (provider.variationPositive) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Variazione Positivi',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: positiveData,
        ),
      );
    }

    if (provider.newPositive) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Nuovi Positivi',
          colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: newPositiveData,
        ),
      );
    }

    if (provider.deaths) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Nuovi Deceduti',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: deathData,
        ),
      );
    }

    if (provider.recovered) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Variazione Guariti',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: recoveredData,
        ),
      );
    }

    if (provider.hospitalized) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Variazione Ospedalizzazioni',
          colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: hospData,
        ),
      );
    }

    if (provider.therapy) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Variazione T.I.',
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: tiData,
        ),
      );
    }

    return toReturn;
  }

  static List<charts.Series<LineChartData, DateTime>> _createTotalData(
      DailyProvider provider) {
    final recaps = provider.lastRecaps;

    final positiveData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.totalePositivi);
    }).toList();

    final newPositiveData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.totaleCasi);
    }).toList();

    final deathData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.deceduti);
    }).toList();

    final recoveredData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.dimessiGuariti);
    }).toList();

    final hospData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.totaleOspedalizzati);
    }).toList();

    final tiData = recaps.map((e) {
      return LineChartData(e.parsedDate, e.terapiaIntensiva);
    }).toList();

    final List<charts.Series<LineChartData, DateTime>> toReturn = [];
    if (provider.variationPositive) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Variazione Positivi',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: positiveData,
        ),
      );
    }

    if (provider.newPositive) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Nuovi Positivi',
          colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: newPositiveData,
        ),
      );
    }

    if (provider.deaths) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Nuovi Deceduti',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: deathData,
        ),
      );
    }

    if (provider.recovered) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Variazione Guariti',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: recoveredData,
        ),
      );
    }

    if (provider.hospitalized) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Variazione Ospedalizzazioni',
          colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: hospData,
        ),
      );
    }

    if (provider.therapy) {
      toReturn.add(
        charts.Series<LineChartData, DateTime>(
          id: 'Variazione T.I.',
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (LineChartData cases, _) => cases.time,
          measureFn: (LineChartData cases, _) => cases.cases,
          data: tiData,
        ),
      );
    }

    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    charts.RenderSpec<num> renderSpecPrimary = AxisTheme.axisThemeNum();
    charts.RenderSpec<DateTime> renderSpecDomain = AxisTheme.axisThemeDateTime();

    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: renderSpecDomain,
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          zeroBound: false,
        ),
        renderSpec: renderSpecPrimary,
      ),
    );
  }
}

class LineChartData {
  final DateTime time;
  final int cases;

  LineChartData(this.time, this.cases);
}

// Dark mode labels fix
class AxisTheme {
  static charts.RenderSpec<num> axisThemeNum() {
    return charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
      lineStyle: charts.LineStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
    );
  }

  static charts.RenderSpec<DateTime> axisThemeDateTime() {
    return charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
      lineStyle: charts.LineStyleSpec(
        color: charts.MaterialPalette.transparent,
      ),
    );
  }
}