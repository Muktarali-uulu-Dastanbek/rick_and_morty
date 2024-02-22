import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/presentation/logic/bloc/characters_bloc.dart';
import 'package:rick_and_morty/internal/dependensies/get_it.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';
import 'package:rick_and_morty/internal/helpers/utils.dart';

class CharacterInfoScreen extends StatefulWidget {
  final CharacterModel characterModel;
  const CharacterInfoScreen({super.key, required this.characterModel});

  @override
  State<CharacterInfoScreen> createState() => _CharacterInfoScreenState();
}

class _CharacterInfoScreenState extends State<CharacterInfoScreen> {
  CharactersBloc charactersBloc = getIt<CharactersBloc>();

  @override
  void initState() {
    charactersBloc
        .add(GetAllEpisodsInCharInfo(episode: widget.characterModel.episode!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var character = widget.characterModel;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(220.0.h),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(character.image ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 180.h,
                    child: Container(
                      height: 150.h,
                      width: 150.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 187.h,
                    child: Container(
                      height: 135.h,
                      width: 135.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(character.image ?? ''),
                        ),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.h),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  // color: Colors.red,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          widget.characterModel.name ?? "",
                          style: TextHelper.s24w600,
                        ),
                        Text(
                          statusConverter(character.status),
                          style: TextStyle(
                            color: statusColorConverter(character.status),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(height: 26.h),
                        Text(
                          "Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.",
                          style: TextHelper.s13w400,
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Пол",
                                    style: TextHelper.s12w400,
                                  ),
                                  Text(
                                    "Мужской",
                                    style: TextHelper.s14w500,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Расса",
                                    style: TextHelper.s12w400,
                                  ),
                                  Text(
                                    "Человек",
                                    style: TextHelper.s14w500,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Место рождения",
                                  style: TextHelper.s12w400,
                                ),
                                Text(
                                  "Человек",
                                  style: TextHelper.s14w500,
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Местоположение",
                                  style: TextHelper.s12w400,
                                ),
                                Text(
                                  "Человек",
                                  style: TextHelper.s14w500,
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Divider(color: Colors.grey[400]),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Эпизоды",
                              style: TextHelper.s24w600,
                            ),
                            Text(
                              "Все эпизоды",
                              style: TextHelper.s12w400,
                            ),
                          ],
                        ),
                        Container(
                          height: 700,
                          width: 400,
                          // color: Colors.blue,
                          child: BlocConsumer<CharactersBloc, CharactersState>(
                            bloc: charactersBloc,
                            listener: (context, state) {
                              if (state is EpisodsInCharInfoErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            state.error.message.toString())));
                              }
                            },
                            builder: (context, state) {
                              if (state is EpisodsInCharInfoLoadingState) {
                                return const CustomSpinner();
                              }

                              if (state is EpisodsInCharInfoLoadedState) {
                                return ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  // padding: EdgeInsets.zero,
                                  itemCount: state.episodsInCharInfo.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 74.h,
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                // "${state.episodsInCharInfo[index].episodImage}",
                                                "assets/images/locations/location1.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 18.w),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "СЕРИЯ ${state.episodsInCharInfo[index].id}",
                                                ),
                                                Text(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  "${state.episodsInCharInfo[index].name}",
                                                  style: TextHelper.s13w400,
                                                ),
                                                Text(
                                                  "${state.episodsInCharInfo[index].airDate}",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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
