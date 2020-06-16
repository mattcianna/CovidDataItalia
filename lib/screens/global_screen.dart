import 'package:covid/providers/daily_provider.dart';
import 'package:covid/screens/line_chart_widget.dart';
import 'package:covid/screens/info_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GlobalScreen extends StatelessWidget {
  Future<void> _fetchData(BuildContext context) async {
    await Provider.of<DailyProvider>(context, listen: false).findRecaps();
  }

  // Charts
  List<Widget> _buildCharts(
      BuildContext context, DailyProvider covidData, bool landscape) {
    return landscape
        ? _buildLandscapeCharts(context, covidData)
        : _buildPortraitCharts(context, covidData);
  }

  List<Widget> _buildLandscapeCharts(
      BuildContext context, DailyProvider covidData) {
    return [
      Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    "Variazione casi",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    padding: EdgeInsets.all(12),
                    child: LineChartWidget.withVariationData(covidData),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    "Totale Casi",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    padding: EdgeInsets.all(12),
                    child: LineChartWidget.withTotalData(covidData),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> _buildPortraitCharts(
      BuildContext context, DailyProvider covidData) {
    return [
      Text(
        "Variazione casi",
        style: Theme.of(context).textTheme.headline5,
      ),
      Container(
        padding: EdgeInsets.all(12),
        height: MediaQuery.of(context).size.height / 3,
        child: LineChartWidget.withVariationData(covidData),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        "Totale casi",
        style: Theme.of(context).textTheme.headline5,
      ),
      Container(
        padding: EdgeInsets.all(12),
        height: MediaQuery.of(context).size.height / 3,
        child: LineChartWidget.withTotalData(covidData),
      ),
      SizedBox(
        height: 30,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final enoughXSpace = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Nazionali"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed("/settings"),
          )
        ],
      ),
      body: FutureBuilder(
        future: _fetchData(context),
        builder: (c, snap) {
          return snap.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => _fetchData(context),
                  child: Consumer<DailyProvider>(
                    builder: (ct, covidData, _) {
                      final last = covidData.lastRecaps.last;
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: enoughXSpace ? 6 : 2,
                              childAspectRatio: 4/2.5,
                              children: <Widget>[
                                InfoTile(
                                  title: "Attualmente positivi",
                                  totalNumber: last.totalePositivi,
                                  variationNumber:
                                  last.variazioneTotalePositivi,
                                  color: Colors.blue,
                                ),
                                InfoTile(
                                  title: "Deceduti",
                                  totalNumber: last.deceduti,
                                  variationNumber: last.nuoviDeceduti,
                                  color: Colors.red,
                                ),
                                InfoTile(
                                  title: "Positivi",
                                  totalNumber: last.totaleCasi,
                                  variationNumber: last.nuoviPositivi,
                                  color: Colors.purple,
                                ),
                                InfoTile(
                                  title: "Dimessi guariti",
                                  totalNumber: last.dimessiGuariti,
                                  variationNumber: last.nuoviGuariti,
                                  color: Colors.green,
                                ),
                                InfoTile(
                                  title: "Ospedalizzati",
                                  totalNumber: last.totaleOspedalizzati,
                                  variationNumber: last.variazioneOspedalizzati,
                                  color: Colors.amber,
                                ),
                                InfoTile(
                                  title: "Terapia intensiva",
                                  totalNumber: last.terapiaIntensiva,
                                  variationNumber:
                                  last.variazioneTerapiaIntensiva,
                                  color: Colors.deepOrange,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ..._buildCharts(context, covidData, landscape)
                          ],
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
