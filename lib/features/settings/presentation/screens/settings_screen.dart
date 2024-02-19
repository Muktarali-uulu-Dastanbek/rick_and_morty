import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Настройки"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pushNamed('/account_screen');
            },
            child: Text("Редактировать"),
          ),
          Center(
            child: Text("Settings Screen"),
          ),
        ],
      ),
    );
  }
}
