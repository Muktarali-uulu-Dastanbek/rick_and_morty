import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';
import 'package:rick_and_morty/internal/helpers/utils.dart';

class CharacterInfoScreen extends StatefulWidget {
  final CharacterModel characterModel;
  const CharacterInfoScreen({super.key, required this.characterModel});

  @override
  State<CharacterInfoScreen> createState() => _CharacterInfoScreenState();
}

class _CharacterInfoScreenState extends State<CharacterInfoScreen> {
  @override
  Widget build(BuildContext context) {
    var character = widget.characterModel;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(220.0.h),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(character.image ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 180.h,
                    child: Container(
                      height: 150.h,
                      width: 150.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 187.h,
                    child: Container(
                      height: 135.h,
                      width: 135.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(character.image ?? ''),
                        ),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.h),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  // color: Colors.red,
                ),
                Text(
                  widget.characterModel.name ?? "",
                  style: TextHelper.s24w600,
                ),
                Text(
                  statusConverter(character.status),
                  style: TextStyle(
                    color: statusColorConverter(character.status),
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 26.h),
                        Text(
                          "Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.",
                          style: TextHelper.s13w400,
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Пол",
                                    style: TextHelper.s12w400,
                                  ),
                                  Text(
                                    "Мужской",
                                    style: TextHelper.s14w500,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Расса",
                                    style: TextHelper.s12w400,
                                  ),
                                  Text(
                                    "Человек",
                                    style: TextHelper.s14w500,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Место рождения",
                                  style: TextHelper.s12w400,
                                ),
                                Text(
                                  "Человек",
                                  style: TextHelper.s14w500,
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Местоположение",
                                  style: TextHelper.s12w400,
                                ),
                                Text(
                                  "Человек",
                                  style: TextHelper.s14w500,
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Divider(color: Colors.grey[400]),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Эпизоды",
                              style: TextHelper.s24w600,
                            ),
                            Text(
                              "Все эпизоды",
                              style: TextHelper.s12w400,
                            ),
                          ],
                        ),
                        // ListView.builder(
                        //   // controller: _scrollController,
                        //   padding: EdgeInsets.zero,
                        //   itemCount: character.episode!.length,
                        //   itemBuilder: (context, index) {
                        //     return InkWell(
                        //       onTap: () {
                        //         Navigator.pushNamed(
                        //           context,
                        //           '/character_info',
                        //         );
                        //       },
                        //       child: Container(
                        //         margin: const EdgeInsets.symmetric(vertical: 5),
                        //         // color: Colors.grey[300],
                        //         child: Row(
                        //           children: [
                        //             Container(
                        //               height: 74.h,
                        //               width: 74.w,
                        //               decoration: const BoxDecoration(
                        //                 // color: Colors.white,
                        //                 shape: BoxShape.circle,
                        //               ),
                        //               child: ClipOval(
                        //                 child: Image.network(
                        //                   "${character.image}",
                        //                   fit: BoxFit.fill,
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(width: 18.w),
                        //             Column(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   statusConverter(character.status),
                        //                   style: TextStyle(
                        //                     color: statusColorConverter(
                        //                         character.status),
                        //                     fontWeight: FontWeight.w500,
                        //                   ),
                        //                 ),
                        //                 Text(
                        //                   "${character.name}",
                        //                   style: TextHelper.s14w500,
                        //                 ),
                        //                 Text(
                        //                   "${character.species.toString().split('.')[1]}, ${character.gender.toString().split('.')[1]}",
                        //                   style: TextHelper.s12w400,
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
