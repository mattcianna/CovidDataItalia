import 'package:covid/providers/daily_provider.dart';
import 'package:covid/providers/region_provider.dart';
import 'package:covid/screens/global_screen.dart';
import 'package:covid/screens/regions_screen.dart';
import 'package:covid/screens/settings_screen.dart';
import 'package:covid/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DailyProvider()),
        ChangeNotifierProvider.value(value: RegionProvider()),
      ],
      child: MaterialApp(
        title: 'Covid',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.blue,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TabsScreen(),
        routes: {
          "/settings": (_) => SettingsScreen(),
        },
      ),
    );
  }
}