import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/presentation/logic/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/character_info_screen.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/my_persistent_header_delegate.dart';

class CharInfoCustomScroll extends StatelessWidget {
  const CharInfoCustomScroll({
    super.key,
    required this.character,
    required this.widget,
    required this.state,
  });
  final CharacterInfoLoadedState state;
  final CharacterModel character;
  final CharacterInfoScreen widget;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: false,
          delegate: MyPersistentHeaderDelegate(
            character: character,
            widget: widget,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: state.episods.length,
            (BuildContext context, int index) {
              return Container(
                color: Theme.of(context).colorScheme.background,
                height: 74.h,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
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
                          // "${state.episods[index].episodImage}",
                          "${state.episods[index].episodImage}",
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
                            "СЕРИЯ ${state.episods[index].id}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            "${state.episods[index].name}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "${state.episods[index].airDate}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
