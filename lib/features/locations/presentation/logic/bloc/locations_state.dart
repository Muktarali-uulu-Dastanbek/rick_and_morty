// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'locations_bloc.dart';

@immutable
sealed class LocationsState {}

final class LocationsInitialState extends LocationsState {}

class LocationsLoadingState extends LocationsState {}

class LocationsLoadedState extends LocationsState {
  final LocationsResult locationsModel;

  LocationsLoadedState({required this.locationsModel});
}

class LocationsErrorState extends LocationsState {
  final CatchException error;

  LocationsErrorState({required this.error});
}
