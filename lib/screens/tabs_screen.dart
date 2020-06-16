import 'package:covid/screens/global_screen.dart';
import 'package:covid/screens/regions_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  final _screens = [
    GlobalScreen(),
    RegionsScreen(),
  ];

  final _titles = [
    "Nazionali",
    "Regionali",
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            title: Text(
              _titles[0],
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            title: Text(
              _titles[1],
            ),
          ),
        ],
      ),
    );
  }
}