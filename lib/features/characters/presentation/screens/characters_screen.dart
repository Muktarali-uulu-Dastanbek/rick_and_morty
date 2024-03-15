import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/presentation/logic/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/characters_shimmer.dart';
import 'package:rick_and_morty/features/locations/presentation/screens/locations_screen.dart';
import 'package:rick_and_morty/internal/dependensies/get_it.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';
import 'package:rick_and_morty/internal/helpers/theme_helper.dart';
import 'package:rick_and_morty/internal/helpers/utils.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  CharactersBloc charactersBloc = getIt<CharactersBloc>();
  late ScrollController _scrollController;
  CancelToken? _cancelToken;

  bool isLoading = false;
  int currentPage = 1;
  List<CharacterModel> charactersList = [];
  bool _theEnd = false;

  @override
  void initState() {
    _cancelToken = CancelToken();
    charactersBloc.add(
      GetAllCharacters(
        currentPage: currentPage,
        isFirstCall: true,
        cancelToken: _cancelToken,
      ),
    );
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _cancelToken?.cancel("Вышел из экрана Персонажи");
    super.dispose();
  }

  _scrollListener() {
    if (charactersList.isNotEmpty) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // isLoading = true;

        if (isLoading) {
          currentPage = currentPage + 1;

          charactersBloc.add(
            GetAllCharacters(
              currentPage: currentPage,
              isFirstCall: false,
            ),
          );
        }
      }
    }
  }

  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.primary,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 15.h,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                hintText: 'Найти персонажа',
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                suffixIcon: Icon(
                  Icons.filter_list_alt,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocConsumer<CharactersBloc, CharactersState>(
              bloc: charactersBloc,
              listener: (context, state) {
                if (state is CharactersLoadedState) {
                  charactersList.addAll(state.charactersResult.results ?? []);
                  if (charactersList.length <
                      state.charactersResult.info!.count!) {
                    isLoading = true;
                  } else {
                    isLoading = false;
                    setState(() {
                      _theEnd = true;
                    });
                  }
                }
                if (state is CharactersErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error.message.toString())));
                }
              },
              builder: (context, state) {
                if (state is CharactersLoadingState) {
                  return const CharactersShimmer();
                }

                if (state is CharactersLoadedState) {
                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ВСЕГО ПЕРСОНАЖЕЙ: ${state.charactersResult.info?.count}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                !isGrid
                                    ? Icons.grid_view_rounded
                                    : Icons.list_alt,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    isGrid = !isGrid;
                                  },
                                );
                              },
                            ),
                            SizedBox(width: 14.w),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: isGrid
                                ? GridView.builder(
                                    controller: _scrollController,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // Количество столбцов
                                      crossAxisSpacing:
                                          8.0, // Расстояние между столбцами
                                      mainAxisSpacing:
                                          8.0, // Расстояние между строками
                                    ),
                                    itemCount: charactersList.length,
                                    itemBuilder: (context, index) {
                                      if (index >= charactersList.length - 1 &&
                                          !_theEnd) {
                                        return const CustomSpinner();
                                      }
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/character_info_screen',
                                            arguments: charactersList[index],
                                          );
                                        },
                                        child: Container(
                                          // color: Colors.grey[300],
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 74.h,
                                                width: 74.w,
                                                decoration: const BoxDecoration(
                                                  // color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipOval(
                                                  child: Image.network(
                                                    "${charactersList[index].image}",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 18.h),
                                              Text(
                                                statusConverter(
                                                    charactersList[index]
                                                        .status),
                                                style: TextStyle(
                                                  color: statusColorConverter(
                                                      charactersList[index]
                                                          .status),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                "${charactersList[index].name}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "${speciesConverter(charactersList[index].species)}, ${genderConverter(charactersList[index].gender)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    controller: _scrollController,
                                    padding: EdgeInsets.zero,
                                    itemCount: charactersList.length,
                                    itemBuilder: (context, index) {
                                      if (index >= charactersList.length - 1 &&
                                          !_theEnd) {
                                        return const CustomSpinner();
                                      }
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/character_info_screen',
                                            arguments: charactersList[index],
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          // color: Colors.grey[300],
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 74.h,
                                                width: 74.w,
                                                decoration: const BoxDecoration(
                                                  // color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipOval(
                                                  child: Image.network(
                                                    "${charactersList[index].image}",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 18.w),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    statusConverter(
                                                        charactersList[index]
                                                            .status),
                                                    style: TextStyle(
                                                      color:
                                                          statusColorConverter(
                                                              charactersList[
                                                                      index]
                                                                  .status),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${charactersList[index].name}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                  Text(
                                                    "${speciesConverter(charactersList[index].species)}, ${genderConverter(charactersList[index].gender)}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
