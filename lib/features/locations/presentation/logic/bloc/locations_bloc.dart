import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/locations/data/models/locations.model.dart';
import 'package:rick_and_morty/features/locations/domain/use_cases/locations_use_cases.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception.dart';

part 'locations_event.dart';
part 'locations_state.dart';

@injectable
class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final LocationsUseCase locationsUseCase;
  LocationsBloc(this.locationsUseCase) : super(LocationsInitialState()) {
    on<GetAllLocations>((event, emit) async {
      try {
        emit(LocationsLoadingState());

        LocationsResult result = await locationsUseCase.getAllLocations();
        log("$result");

        emit(LocationsLoadedState(locationsResult: result));
      } catch (e) {
        print('ошибка $e');
        emit(
          LocationsErrorState(
            error: CatchException.convertException(e),
          ),
        );
      }
    });
  }
}
