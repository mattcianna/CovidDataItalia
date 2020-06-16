import 'dart:convert';

import 'package:covid/models/daily_recap.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DailyProvider with ChangeNotifier {
  List<DailyRecap> _recaps = [];

  List<DailyRecap> get lastRecaps {
    if (!last15) {
      return [..._recaps];
    }
    if (_recaps.length < 15) {
      return [..._recaps];
    }
    return [..._recaps.sublist(_recaps.length - 15)];
  }

  Future<void> findRecaps() async {
    try {
      final response = await http.get(
              "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/"
              "dpc-covid19-ita-andamento-nazionale.json");

      final json = List<Map<dynamic, dynamic>>.from(jsonDecode(response.body));
      _recaps = json.map((e) {
            return DailyRecap.fromMap(e);
          }).toList();
      //_recaps.sort((a, b) => a.totaleCasi.compareTo(b.totaleCasi));

      for (int i = 0; i < _recaps.length; i++) {
        if (i == 0) {
          _recaps[i].nuoviDeceduti = _recaps[i].deceduti;
          _recaps[i].nuoviGuariti = _recaps[i].dimessiGuariti;
          _recaps[i].variazioneTerapiaIntensiva = _recaps[i].terapiaIntensiva;
          _recaps[i].variazioneOspedalizzati = _recaps[i].totaleOspedalizzati;
          continue;
        }
        final deathToday = _recaps[i].deceduti;
        final deathYesterday = _recaps[i - 1].deceduti;
        _recaps[i].nuoviDeceduti = deathToday - deathYesterday;

        final recoverToday = _recaps[i].dimessiGuariti;
        final recoverYesterday = _recaps[i - 1].dimessiGuariti;
        _recaps[i].nuoviGuariti = recoverToday - recoverYesterday;

        final tiToday = _recaps[i].terapiaIntensiva;
        final tiYesterday = _recaps[i - 1].terapiaIntensiva;
        _recaps[i].variazioneTerapiaIntensiva = tiToday - tiYesterday;

        final hospToday = _recaps[i].totaleOspedalizzati;
        final hospYesterday = _recaps[i - 1].totaleOspedalizzati;
        _recaps[i].variazioneOspedalizzati = hospToday - hospYesterday;

      }

      print(lastRecaps);
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  bool last15 = false;

  bool variationPositive = true;
  bool deaths = true;
  bool newPositive = true;
  bool recovered = false;
  bool hospitalized = false;
  bool therapy = false;

  void setLast15(bool v) {
    last15 = v;
    notifyListeners();
  }

  void setVariationPositive(bool v) {
    variationPositive = v;
    notifyListeners();
  }

  void setDeaths(bool v) {
    deaths = v;
    notifyListeners();
  }

  void setNewPositive(bool v) {
    newPositive = v;
    notifyListeners();
  }

  void setRecovered(bool v) {
    recovered = v;
    notifyListeners();
  }

  void setHospitalized(bool v) {
    hospitalized = v;
    notifyListeners();
  }

  void setTherapy(bool v) {
    therapy = v;
    notifyListeners();
  }

}
