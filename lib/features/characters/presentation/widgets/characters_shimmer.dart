import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CharactersShimmer extends StatelessWidget {
  const CharactersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CommonShimmer(
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ВСЕГО ПЕРСОНАЖЕЙ: ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.grid_view_rounded),
                  onPressed: () {},
                ),
                SizedBox(width: 14.w),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 74.h,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
