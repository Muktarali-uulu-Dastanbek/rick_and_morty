// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/characters_shimmer.dart';
import 'package:rick_and_morty/features/episods/data/models/episods_model.dart';

class EpisodInfoAppBar extends SliverPersistentHeaderDelegate {
  EpisodModel episodModel;
  var widget;

  EpisodInfoAppBar({
    required this.episodModel,
    required this.widget,
  });

  @override
  double get minExtent => 520.0.h; // Минимальная высота заголовка
  @override
  double get maxExtent => 520.0.h; // Максимальная высота заголовка

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Stack(
              children: [
                Container(
                  height: 270.h,
                  width: double.infinity,
                  child: Image.asset(
                    "${widget.episodModel.episodImage}",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 236.h),
                    Container(
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.episodModel.name}",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "СЕРИЯ ${widget.episodModel.id}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 26.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концен-трирован- ной темной материи.",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 15.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Премьера",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "${episodModel.airDate}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Divider(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Персонажи",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: 6.h),
                      ],
                    ),
                  ],
                ),
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

class EpisodInfoAppBarShimmer extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 520.0.h; // Минимальная высота заголовка
  @override
  double get maxExtent => 520.0.h; // Максимальная высота заголовка

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Stack(
              children: [
                CommonShimmer(
                  child: Container(
                    height: 270.h,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 236.h),
                    Container(
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Name",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Text(
                      "СЕРИЯ  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 26.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концен-трирован- ной темной материи.",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 15.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Премьера",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Divider(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Персонажи",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: 6.h),
                      ],
                    ),
                  ],
                ),
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
