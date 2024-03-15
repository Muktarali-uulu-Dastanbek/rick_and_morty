import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/episods/presentation/widgets/episod_info_appbar.dart';
import 'package:shimmer/shimmer.dart';

class EpisodInfoShimmer extends StatelessWidget {
  const EpisodInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: false,
          delegate: EpisodInfoAppBarShimmer(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 5,
            (BuildContext context, int index) {
              return CommonShimmer(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 74,
                  width: double.infinity,
                  color: Colors.grey,
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
