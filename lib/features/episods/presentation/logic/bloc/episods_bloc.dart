import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/episods/data/models/episods_model.dart';
import 'package:rick_and_morty/features/episods/domain/use_cases/episods_use_cases.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception.dart';

part 'episods_event.dart';
part 'episods_state.dart';

@injectable
class EpisodsBloc extends Bloc<EpisodsEvent, EpisodsState> {
  EpisodsUseCase episodsUseCase;
  EpisodsBloc(this.episodsUseCase) : super(EpisodsInitialState()) {
    on<GetAllEpisodsEvent>((event, emit) async {
      try {
        emit(EpisodsLoadingState());

        EpisodsResult result = await episodsUseCase.getAllEpisods();
        log("$result");

        emit(EpisodsLoadedState(episodsResult: result));
      } catch (e) {
        print('ошибка $e');
        emit(
          EpisodsErrorState(
            error: CatchException.convertException(e),
          ),
        );
      }
    });
  }
}
