import 'package:flutter/material.dart';
import 'package:npocnm/screens/main/feed.dart';
import 'package:npocnm/screens/main/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static List<Widget> widgetOptions = <Widget>[
    Feed(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.code,
              color: selectedIndex == 0 ? Colors.white : Colors.white38,
            ),
            label: AppLocalizations.of(context)!.feed,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: selectedIndex == 1 ? Colors.white : Colors.white38,
            ),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
        unselectedItemColor: Colors.white38,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        onTap: onItemTapped,
      ),
    );
  }
}
