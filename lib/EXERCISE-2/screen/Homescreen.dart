import 'package:flutter/material.dart';
import 'CounterScreen.dart';
import 'StaticScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    CounterScreen(),
    const StaticScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('HomeScreen rebuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Counters'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.color_lens),
            label: 'Tap Colors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Tap Count',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
