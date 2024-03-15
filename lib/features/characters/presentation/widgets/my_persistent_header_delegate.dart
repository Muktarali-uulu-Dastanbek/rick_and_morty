// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_info_shimmer.dart';
import 'package:rick_and_morty/internal/helpers/utils.dart';

class MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  CharacterModel character;
  var widget;

  MyPersistentHeaderDelegate({
    required this.character,
    required this.widget,
  });

  @override
  double get minExtent => 750.0.h; // Минимальная высота заголовка
  @override
  double get maxExtent => 750.0.h; // Максимальная высота заголовка

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      // color: Colors.red,
      child: Column(
        children: [
          Container(
            height: 550,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  children: [
                    AppBar(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      flexibleSpace: Container(
                        height: 250.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(character.image ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 190.h,
                      // color: Colors.red,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.characterModel.name ?? "",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            statusConverter(character.status),
                            style: TextStyle(
                              color: statusColorConverter(character.status),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(character.image ?? ""),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.background,
                      width: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Пол",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              genderConverter(character.gender),
                              style: Theme.of(context).textTheme.bodyLarge,
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
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              speciesConverter(character.species),
                              style: Theme.of(context).textTheme.bodyLarge,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "${character.origin!.name}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.primaryContainer,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "${character.location!.name}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        size: 16,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Divider(color: Colors.grey[400]),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Эпизоды",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "Все эпизоды",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class MyPersistentHeaderDelegate2 extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 750.0.h; // Минимальная высота заголовка
  @override
  double get maxExtent => 750.0.h; // Максимальная высота заголовка

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      // color: Colors.red,
      child: Column(
        children: [
          Container(
            height: 550,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  children: [
                    AppBar(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      flexibleSpace: CommonShimmer(
                        child: Container(
                          color: Colors.white,
                          height: 250.h,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 190.h,
                      // color: Colors.red,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Name",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(""),
                          SizedBox(height: 20.h),
                          Text(
                            "Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CommonShimmer(
                  child: Container(
                    width: 150.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.background,
                        width: 9,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Пол",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "",
                              style: Theme.of(context).textTheme.bodyLarge,
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
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "",
                              style: Theme.of(context).textTheme.bodyLarge,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.primaryContainer,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        size: 16,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Divider(color: Colors.grey[400]),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Эпизоды",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "Все эпизоды",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
