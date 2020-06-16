import 'package:covid/providers/daily_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Impostazioni"),
        ),
        body: Consumer<DailyProvider>(
          builder: (c, covidData, _) {
            return ListView(
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Ultimi 15 giorni",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SwitchListTile.adaptive(
                  activeColor: Colors.blue,
                  value: covidData.last15,
                  onChanged: (v) => covidData.setLast15(v),
                  title: Text("Mostra ultimi 15 giorni"),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Filtri",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SwitchListTile.adaptive(
                  activeColor: Colors.blue,
                  value: covidData.variationPositive,
                  onChanged: (v) => covidData.setVariationPositive(v),
                  title: Text("Attualmente positivi"),
                ),
                Divider(),
                SwitchListTile.adaptive(
                  activeColor: Colors.red,
                  value: covidData.deaths,
                  onChanged: (v) => covidData.setDeaths(v),
                  title: Text("Deceduti"),
                ),
                Divider(),
                SwitchListTile.adaptive(
                  activeColor: Colors.purple,
                  value: covidData.newPositive,
                  onChanged: (v) => covidData.setNewPositive(v),
                  title: Text("Positivi"),
                ),
                Divider(),
                SwitchListTile.adaptive(
                  activeColor: Colors.green,
                  value: covidData.recovered,
                  onChanged: (v) => covidData.setRecovered(v),
                  title: Text("Dimessi guariti"),
                ),
                Divider(),
                SwitchListTile.adaptive(
                  activeColor: Colors.amber,
                  value: covidData.hospitalized,
                  onChanged: (v) => covidData.setHospitalized(v),
                  title: Text("Ospedalizzati"),
                ),
                Divider(),
                SwitchListTile.adaptive(
                  activeColor: Colors.orange,
                  value: covidData.therapy,
                  onChanged: (v) => covidData.setTherapy(v),
                  title: Text("Terapia intensiva"),
                ),
              ],
            );
          },
        ));
  }
}
