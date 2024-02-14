import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/presentation/logic/bloc/characters_bloc.dart';
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
  bool isLoading = false;
  int currentPage = 1;
  List<CharacterResult> charactersList = [];

  @override
  void initState() {
    charactersBloc.add(
      GetAllCharacters(
        currentPage: currentPage,
        isFirstCall: true,
      ),
    );
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (charactersList.isNotEmpty) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        isLoading = true;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF2F2F2),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 15.h,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                hintText: 'Найти персонажа',
                hintStyle: TextHelper.hintText,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Icon(
                  Icons.filter_list_alt,
                  color: ThemeColor.hintTextCl,
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
                  charactersList.addAll(state.characterModel.results ?? []);

                  isLoading = false;
                }
                if (state is CharactersErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error.message.toString())));
                }
              },
              builder: (context, state) {
                if (state is CharactersLoadingState) {
                  return const CircularProgressIndicator();
                }

                if (state is CharactersLoadedState) {
                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "ВСЕГО ПЕРСОНАЖЕЙ: ${state.characterModel.info?.count}"),
                            Spacer(),
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
                          child: Container(
                            width: double.infinity,
                            child: isGrid
                                ? GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // Количество столбцов
                                      crossAxisSpacing:
                                          8.0, // Расстояние между столбцами
                                      mainAxisSpacing:
                                          8.0, // Расстояние между строками
                                    ),
                                    itemCount:
                                        state.characterModel.results!.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('/character_info');
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
                                                    "${state.characterModel.results![index].image}",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 18.h),
                                              Text(
                                                statusConverter(state
                                                    .characterModel
                                                    .results![index]
                                                    .status),
                                                style: TextStyle(
                                                  color: statusColorConverter(
                                                      state
                                                          .characterModel
                                                          .results![index]
                                                          .status),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                "${state.characterModel.results![index].name}",
                                                style: TextHelper.s14w500,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "${state.characterModel.results![index].species.toString().split('.')[1]}, ${state.characterModel.results![index].gender.toString().split('.')[1]}",
                                                style: TextHelper.s12w400,
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
                                      if (index >= charactersList.length - 1) {
                                        return const CustomSpinner();
                                      }
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('/character_info');
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
                                                    style: TextHelper.s14w500,
                                                  ),
                                                  Text(
                                                    "${charactersList[index].species.toString().split('.')[1]}, ${charactersList[index].gender.toString().split('.')[1]}",
                                                    style: TextHelper.s12w400,
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

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child:
          // Platform.isAndroid
          //     ? const CircularProgressIndicator()
          //     :
          CupertinoActivityIndicator(
        radius: 15.r,
        color: Colors.grey,
      ),
    );
  }
}
