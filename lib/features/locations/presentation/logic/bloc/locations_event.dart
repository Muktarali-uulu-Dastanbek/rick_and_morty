// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'locations_bloc.dart';

@immutable
sealed class LocationsEvent {}

class GetAllLocations extends LocationsEvent {
  final int currentPage;
  final bool isFirstCall;

  GetAllLocations({
    required this.currentPage,
    this.isFirstCall = false,
  });
}
