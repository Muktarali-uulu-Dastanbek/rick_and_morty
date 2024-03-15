import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/settings/presentation/screens/theme_manager.dart';

class BlackThemeWidget extends StatefulWidget {
  const BlackThemeWidget({Key? key}) : super(key: key);

  @override
  _BlackThemeWidgetState createState() => _BlackThemeWidgetState();
}

class _BlackThemeWidgetState extends State<BlackThemeWidget> {
  bool _isDarkThemeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      child: Row(
        children: [
          // Container(
          //   width: 37.w,
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage("assets/images/black_theme.png"),
          //     ),
          //   ),
          // ),
          Icon(
            Icons.color_lens,
            color: Theme.of(context).colorScheme.secondary,
            size: 45,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Темная тема",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                _isDarkThemeEnabled ? "Включена" : "Выключена",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Выберите режим темы',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Включить темную тему'),
                          leading: Radio(
                            activeColor: Colors.grey,
                            value: true,
                            groupValue: _isDarkThemeEnabled,
                            onChanged: (bool? value) {
                              setState(() {
                                _isDarkThemeEnabled = value!;
                                Provider.of<ThemeManager>(context,
                                        listen: false)
                                    .changeTheme(value!
                                        ? ThemeType.dark
                                        : ThemeType.light);
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Выключить темную тему'),
                          leading: Radio(
                            activeColor: Colors.grey,
                            value: false,
                            groupValue: _isDarkThemeEnabled,
                            onChanged: (bool? value) {
                              setState(
                                () {
                                  _isDarkThemeEnabled = value!;
                                  Provider.of<ThemeManager>(context,
                                          listen: false)
                                      .changeTheme(value!
                                          ? ThemeType.dark
                                          : ThemeType.light);
                                },
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
