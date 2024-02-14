import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_screen.dart';
import 'package:rick_and_morty/features/episods/presentation/screens/episodes_screen.dart';
import 'package:rick_and_morty/features/locations/presentation/screens/location_screen.dart';
import 'package:rick_and_morty/features/settings/presentation/screens/settings_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;
  void onItemTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> screens = const [
    //персонажи
    CharactersScreen(),
    //локация
    LocationScreen(),
    //Эпизоды
    EpisodesScreen(),
    //настройки
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // fixedColor: Colors.red,
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: true,
        // backgroundColor: Colors.blue,
        // iconSize: 24,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black26,
        // selectedIconTheme: IconThemeData(
        //   color: Colors.black,
        // ),
        // selectedLabelStyle: TextStyle(
        //   fontSize: 10,
        //   fontWeight: FontWeight.bold,
        // ),

        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/character.png',
              width: 24,
              height: 24,
            ),
            label: 'Персонажи',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/location_24px.png',
              width: 24,
              height: 24,
            ),
            label: 'Локациии',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/episode.png',
              width: 24,
              height: 24,
            ),
            label: 'Эпизоды',
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Настройки',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTab,
      ),
    );
  }
}
