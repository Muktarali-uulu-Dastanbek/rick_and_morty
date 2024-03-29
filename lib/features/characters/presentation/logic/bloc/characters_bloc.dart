// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/domain/use_case/characters_use_case.dart';
import 'package:rick_and_morty/features/episods/data/models/episods_model.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception.dart';

part 'characters_event.dart';
part 'characters_state.dart';

@injectable
class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersUseCase charactersUseCase;
  CharactersBloc(this.charactersUseCase) : super(CharactersInitialState()) {
    on<GetAllCharacters>((event, emit) async {
      try {
        if (event.isFirstCall) {
          emit(CharactersLoadingState());
        }

        CharactersResult result = await charactersUseCase.getAllCharacters(
          event.currentPage,
          event.cancelToken,
        );
        log("$result");

        emit(CharactersLoadedState(charactersResult: result));
      } catch (e) {
        print('ошибка $e');
        emit(
          CharactersErrorState(
            error: CatchException.convertException(e),
          ),
        );
      }
    });

    on<GetAllEpisodsCharecterInfo>((event, emit) async {
      try {
        emit(CharacterInfoLoadingState());

        List<EpisodModel> episods = [];

        for (int i = 0; i <= event.episods.length - 1; i++) {
          EpisodModel result = await charactersUseCase.getEpisod(
            event.episods[i],
            event.cancelToken,
          );
          episods.add(result);
        }

        emit(CharacterInfoLoadedState(episods: episods));

        // CharactersResult result =
        //     await charactersUseCase.getAllCharacters(event.currentPage);
        // log("$result");

        // emit(CharactersLoadedState(charactersResult: result));
      } catch (e) {
        print('ошибка CharacterInfoErrorState $e');
        emit(
          CharacterInfoErrorState(
            error: CatchException.convertException(e),
          ),
        );
      }
    });
  }
}
