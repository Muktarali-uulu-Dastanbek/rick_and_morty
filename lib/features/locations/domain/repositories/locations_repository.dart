import 'package:rick_and_morty/features/locations/data/models/locations.model.dart';

abstract class LocationsRepository {
  ///RU: получение информации о всех локации
  ///
  ///EN:getting the information of all locations

  Future<LocationsResult> getAllLocations();
}
