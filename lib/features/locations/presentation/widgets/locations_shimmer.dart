import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LocationsShimmer extends StatelessWidget {
  const LocationsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CommonShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ВСЕГО ЛОКАЦИЙ: ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Container(
                width: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 230,
                      margin: EdgeInsets.symmetric(vertical: 5.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
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
