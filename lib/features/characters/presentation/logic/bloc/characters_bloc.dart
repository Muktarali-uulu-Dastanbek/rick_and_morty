// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/domain/use_case/characters_use_case.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception.dart';

part 'characters_event.dart';
part 'characters_state.dart';

@injectable
class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersUseCase userUseCase;
  CharactersBloc(this.userUseCase) : super(CharactersInitialState()) {
    on<GetAllCharacters>((event, emit) async {
      try {
        if (event.isFirstCall) {
          emit(CharactersLoadingState());
        }

        CharactersResult result =
            await userUseCase.getAllCharacters(event.currentPage);
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
  }
}
