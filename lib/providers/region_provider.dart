import 'dart:convert';

import 'package:covid/models/daily_recap.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RegionProvider with ChangeNotifier {
  List<DailyRecap> _recaps = [];

  List<DailyRecap> get recaps {
    return [..._recaps.reversed];
  }

  Future<void> findRecaps() async {
    try {
      final response = await http.get(
          "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/"
              "dpc-covid19-ita-regioni-latest.json");

      final json = List<Map<dynamic, dynamic>>.from(jsonDecode(response.body));
      _recaps = json.map((e) {
        return DailyRecap.fromMap(e);
      }).toList();
      _recaps.sort((a, b) => a.totaleCasi.compareTo(b.totaleCasi));

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
