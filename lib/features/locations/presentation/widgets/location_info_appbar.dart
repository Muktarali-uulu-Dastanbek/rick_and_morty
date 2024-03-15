// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/characters_shimmer.dart';
import 'package:rick_and_morty/features/locations/data/models/locations.model.dart';

class LocationInfoAppBar extends SliverPersistentHeaderDelegate {
  LocationModel location;
  var widget;

  LocationInfoAppBar({
    required this.location,
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
                    "${widget.locationModel.locationImage}",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.locationModel.name}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "${widget.locationModel.type} - ${widget.locationModel.dimension}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 36.h),
                    Text(
                      "Это планета, на которой проживает человеческая раса, и главное место для персонажей Рика и Морти. Возраст этой Земли более 4,6 миллиардов лет, и она является четвертой планетой от своей звезды.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "Персонажи",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 6.h),
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

class LocationInfoAppBarShimmer extends SliverPersistentHeaderDelegate {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "Type - Dimension",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 36.h),
                    Text(
                      "Это планета, на которой проживает человеческая раса, и главное место для персонажей Рика и Морти. Возраст этой Земли более 4,6 миллиардов лет, и она является четвертой планетой от своей звезды.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "Персонажи",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 6.h),
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
