import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/my_persistent_header_delegate.dart';
import 'package:shimmer/shimmer.dart';

class CharacterInfoShimmer extends StatelessWidget {
  const CharacterInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: false,
          delegate: MyPersistentHeaderDelegate2(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 3,
            (BuildContext context, int index) {
              return CommonShimmer(
                child: Container(
                  height: 74.h,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CommonShimmer extends StatelessWidget {
  final Widget child;

  const CommonShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primary,
      highlightColor: Theme.of(context).colorScheme.secondary,
      child: child,
    );
  }
}
