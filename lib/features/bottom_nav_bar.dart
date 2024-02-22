import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_screen.dart';
import 'package:rick_and_morty/features/episods/presentation/screens/episods_screen.dart';
import 'package:rick_and_morty/features/locations/presentation/screens/locations_screen.dart';
import 'package:rick_and_morty/features/settings/presentation/screens/settings_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;
  bool selectCharacters = true;
  bool selectLocations = false;
  bool selectEpisods = false;

  void onItemTab(int index) {
    setState(() {
      selectedIndex = index;
      switch (index) {
        case 0:
          selectCharacters = true;
          selectLocations = false;
          selectEpisods = false;
          break;

        case 1:
          selectCharacters = false;
          selectLocations = true;
          selectEpisods = false;
          break;

        case 2:
          selectCharacters = false;
          selectLocations = false;
          selectEpisods = true;
          break;

        case 3:
          selectCharacters = false;
          selectLocations = false;
          selectEpisods = false;
          break;

        default:
      }
    });
  }

  List<Widget> screens = const [
    //персонажи
    CharactersScreen(),
    //локация
    LocationsScreen(),
    //Эпизоды
    EpisodsScreen(),
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
              color: selectCharacters ? Colors.blue : null,
            ),
            label: 'Персонажи',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/location_24px.png',
              width: 24,
              height: 24,
              color: selectLocations ? Colors.blue : null,
            ),
            label: 'Локациии',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/episode.png',
              width: 24,
              height: 24,
              color: selectEpisods ? Colors.blue : null,
            ),
            label: 'Эпизоды',
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: Colors.blue,
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
