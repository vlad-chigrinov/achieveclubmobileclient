import 'package:achieveclubmobileclient/main.dart';
import 'package:achieveclubmobileclient/tab1.dart';
import 'package:achieveclubmobileclient/tab2.dart';
import 'package:achieveclubmobileclient/tab3.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Function() logoutCallback;

  const HomePage({super.key, required this.logoutCallback});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const Tab1Page(),
    const Tab2Page(),
    const Tab3Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 48.0,
          height: 48.0,
          child: IconButton(
            iconSize: 32.0,
            icon: Transform.rotate(
              angle: 3.14, // 180 градусов в радианах
              child: const Icon(Icons.logout),
            ),
            onPressed: widget.logoutCallback,
          ),
        ),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (_currentIndex) {
              case 0:
                appTitle = 'Профиль';
                break;
              case 1:
                appTitle = 'Топ 100 пользователей';
                break;
              case 2:
                appTitle = 'Топ клубов';
                break;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Топ 100 пользователей',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment),
            label: 'Топ клубов',
          ),
        ],
      ),
    );
  }
}