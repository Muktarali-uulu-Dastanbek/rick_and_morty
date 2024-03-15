import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/episods/data/models/episods_model.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';

class EpisodsView extends StatelessWidget {
  const EpisodsView({
    super.key,
    required this.results,
  });

  final List<EpisodModel>? results;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: results!.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/episod_info_screen',
              arguments: results![index],
            );
          },
          child: Container(
            height: 74.h,
            // width: 300.w,
            margin: const EdgeInsets.symmetric(vertical: 10),
            // color: Colors.grey[300],
            child: Row(
              children: [
                Container(
                  height: 74.h,
                  width: 74.w,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "${results![index].episodImage}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 18.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "СЕРИЯ ${results![index].id}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "${results![index].name}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        "${results![index].airDate}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
