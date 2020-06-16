import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DailyRecap {
  String data;
  String stato;
  String denominazioneRegione;
  int ricoveratiConSintomi;
  int terapiaIntensiva;
  int totaleOspedalizzati;
  int totalePositivi;
  int variazioneTotalePositivi;
  int nuoviPositivi;
  int dimessiGuariti;
  int deceduti;
  int totaleCasi;
  int tamponi;

  int nuoviDeceduti = 0;
  int nuoviGuariti = 0;
  int variazioneTerapiaIntensiva = 0;
  int variazioneOspedalizzati = 0;

  DateTime get parsedDate {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(data);
  }

  DailyRecap({
    @required this.data,
    @required this.stato,
    @required this.denominazioneRegione,
    @required this.ricoveratiConSintomi,
    @required this.terapiaIntensiva,
    @required this.totaleOspedalizzati,
    @required this.totalePositivi,
    @required this.variazioneTotalePositivi,
    @required this.nuoviPositivi,
    @required this.dimessiGuariti,
    @required this.deceduti,
    @required this.totaleCasi,
    @required this.tamponi,
  });

  factory DailyRecap.fromMap(Map<dynamic, dynamic> map) {
    return new DailyRecap(
      data: map['data'] as String,
      stato: map['stato'] as String,
      denominazioneRegione: map['denominazione_regione'] as String ?? "",
      ricoveratiConSintomi: map['ricoverati_con_sintomi'] as int,
      terapiaIntensiva: map['terapia_intensiva'] as int,
      totaleOspedalizzati: map['totale_ospedalizzati'] as int,
      totalePositivi: map['totale_positivi'] as int,
      variazioneTotalePositivi: map['variazione_totale_positivi'] as int,
      nuoviPositivi: map['nuovi_positivi'] as int,
      dimessiGuariti: map['dimessi_guariti'] as int,
      deceduti: map['deceduti'] as int,
      totaleCasi: map['totale_casi'] as int,
      tamponi: map['tamponi'] as int,
    );
  }
}
