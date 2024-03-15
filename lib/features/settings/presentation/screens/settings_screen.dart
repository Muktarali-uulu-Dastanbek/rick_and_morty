import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/settings/presentation/widgets/theme_is_widget.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final user = FirebaseAuth.instance.currentUser;

  bool _isDarkMode = false;

  Future<void> signOut() async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();

    navigator.pushNamedAndRemoveUntil(
        '/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Настройки",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundImage: NetworkImage(
                    "https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg",
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  user!.email!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            SizedBox(height: 30.h),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/account_screen');
              },
              child: Text(
                "Редактировать",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              style: TextButton.styleFrom(
                fixedSize: Size(double.infinity, 40.h),
                minimumSize: Size(double.infinity, 40.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  side: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Divider(color: Colors.grey[300]),
                  SizedBox(height: 20.h),
                  Text(
                    "ВНЕШНИЙ ВИД",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 20.h),
                  const BlackThemeWidget(),
                  SizedBox(height: 20.h),
                  Divider(color: Colors.grey[300]),
                  SizedBox(height: 20.h),
                  Text(
                    "О ПРИЛОЖЕНИИ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концен-трирован- ной темной материи.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 20.h),
                  Divider(color: Colors.grey[300]),
                  SizedBox(height: 20.h),
                  Text(
                    "ВЕРСИЯ ПРИЛОЖЕНИЯ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Rick & Morty  v1.0.0",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      title: Text(
                        'Вы точно хотите выйти?',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'Отмена',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Да',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onPressed: () {
                            signOut();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
              child: Text(
                "Выйти",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      // theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
    );
  }
}
