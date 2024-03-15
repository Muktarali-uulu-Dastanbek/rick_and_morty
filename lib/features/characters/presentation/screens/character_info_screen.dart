import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/presentation/logic/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/char_info_customscroll.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_info_shimmer.dart';
import 'package:rick_and_morty/internal/dependensies/get_it.dart';

class CharacterInfoScreen extends StatefulWidget {
  final CharacterModel characterModel;

  const CharacterInfoScreen({super.key, required this.characterModel});

  @override
  State<CharacterInfoScreen> createState() => _CharacterInfoScreenState();
}

class _CharacterInfoScreenState extends State<CharacterInfoScreen> {
  CharactersBloc charactersBloc = getIt<CharactersBloc>();
  CancelToken? _cancelToken;

  @override
  void initState() {
    _cancelToken = CancelToken();
    charactersBloc.add(
      GetAllEpisodsCharecterInfo(
        episods: widget.characterModel.episode!,
        cancelToken: _cancelToken,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _cancelToken?.cancel("Вышел из экрана Персонаж Детейл");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var character = widget.characterModel;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<CharactersBloc, CharactersState>(
              bloc: charactersBloc,
              listener: (context, state) {
                if (state is CharacterInfoErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error.message.toString())));
                }
              },
              builder: (context, state) {
                if (state is CharacterInfoLoadingState) {
                  return CharacterInfoShimmer();
                  // CupertinoActivityIndicator(
                  //   radius: 15.r,
                  //   color: Colors.grey,
                  // );
                }

                if (state is CharacterInfoLoadedState) {
                  return CharInfoCustomScroll(
                    character: character,
                    widget: widget,
                    state: state,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
