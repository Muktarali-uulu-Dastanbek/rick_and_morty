// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'locations_bloc.dart';

@immutable
sealed class LocationsState {}

final class LocationsInitialState extends LocationsState {}

class LocationsLoadingState extends LocationsState {}

class LocationsLoadedState extends LocationsState {
  final LocationsResult locationsResult;

  LocationsLoadedState({required this.locationsResult});
}

class LocationsErrorState extends LocationsState {
  final CatchException error;

  LocationsErrorState({required this.error});
}

class LocationInfoLoadingState extends LocationsState {}

class LocationInfoLoadedState extends LocationsState {
  final List<CharacterModel> characters;

  LocationInfoLoadedState({required this.characters});
}

class LocationInfoErrorState extends LocationsState {
  final CatchException error;

  LocationInfoErrorState({required this.error});
}
