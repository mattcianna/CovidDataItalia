import 'package:covid/providers/region_provider.dart';
import 'package:covid/screens/pie_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegionsScreen extends StatelessWidget {
  Future<void> _fetchData(BuildContext context) async {
    await Provider.of<RegionProvider>(context, listen: false).findRecaps();
  }

  Widget _buildListView(RegionProvider regionData) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ct, index) {
        final r = regionData.recaps[index];
        return Column(
          children: <Widget>[
            ListTile(
              isThreeLine: true,
              title: Text(r.denominazioneRegione),
              subtitle: Text(
                "Attualmente positivi: ${r.totalePositivi} "
                    "(${r.variazioneTotalePositivi < 0 ? r.variazioneTotalePositivi : "+${r.variazioneTotalePositivi}"})\n"
                    "Positivi: ${r.totaleCasi} "
                    "(${r.nuoviPositivi < 0 ? r.nuoviPositivi : "+${r.nuoviPositivi}"})\n"
                    "Deceduti: ${r.deceduti}",
              ),
            ),
            Divider(),
          ],
        );
      },
      itemCount: regionData.recaps.length,
    );
  }

  Widget _buildLandscapeLayout(RegionProvider regionData) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: DonutAutoLabelChart.withData(regionData.recaps),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(child: _buildListView(regionData)),
        )
      ],
    );
  }

  Widget _buildPortraitLayout(RegionProvider regionData) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: DonutAutoLabelChart.withData(
                regionData.recaps),
          ),
          Container(
            child: _buildListView(regionData),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Text("Regionali"),
      ),
      body: FutureBuilder(
        future: _fetchData(context),
        builder: (c, snap) {
          return snap.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<RegionProvider>(
                  builder: (ct, regionData, _) {
                    return landscape
                        ? _buildLandscapeLayout(regionData)
                        : _buildPortraitLayout(regionData);
                  },
                );
        },
      ),
    );
  }
}
