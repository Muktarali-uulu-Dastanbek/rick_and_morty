part of 'locations_bloc.dart';

@immutable
sealed class LocationsEvent {}

class GetAllLocations extends LocationsEvent {}
