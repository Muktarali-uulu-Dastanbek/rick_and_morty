// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/characters/data/repositories/characters_repository_impl.dart'
    as _i4;
import '../../features/characters/domain/repositories/characters_repository.dart'
    as _i3;
import '../../features/characters/domain/use_case/characters_use_case.dart'
    as _i5;
import '../../features/characters/presentation/logic/bloc/characters_bloc.dart'
    as _i9;
import '../../features/locations/data/repositories/locations_repository_impl.dart'
    as _i7;
import '../../features/locations/domain/repositories/locations_repository.dart'
    as _i6;
import '../../features/locations/domain/use_cases/locations_use_cases.dart'
    as _i8;
import '../../features/locations/presentation/logic/bloc/locations_bloc.dart'
    as _i10;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.CharactersRepository>(() => _i4.UserRepositoriImpl());
  gh.factory<_i5.CharactersUseCase>(() => _i5.CharactersUseCase(
      charactersRepository: gh<_i3.CharactersRepository>()));
  gh.factory<_i6.LocationsRepository>(() => _i7.LocationsRepositoriImpl());
  gh.factory<_i8.LocationsUseCase>(() =>
      _i8.LocationsUseCase(locationsRepository: gh<_i6.LocationsRepository>()));
  gh.factory<_i9.CharactersBloc>(
      () => _i9.CharactersBloc(gh<_i5.CharactersUseCase>()));
  gh.factory<_i10.LocationsBloc>(
      () => _i10.LocationsBloc(gh<_i8.LocationsUseCase>()));
  return getIt;
}
