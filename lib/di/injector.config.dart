// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../app/app/app_cubit.dart' as _i189;
import '../core/storage/local_storage.dart' as _i449;
import '../features/home/presentation/home_cubit.dart' as _i624;
import '../features/profile/presentation/profile_cubit.dart' as _i336;
import '../features/search/presentation/search_cubit.dart' as _i178;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetit(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i624.HomeCubit>(() => _i624.HomeCubit());
  gh.factory<_i178.SearchCubit>(() => _i178.SearchCubit());
  gh.factory<_i336.ProfileCubit>(() => _i336.ProfileCubit());
  gh.singleton<_i449.LocalStorage>(() => _i449.LocalStorage());
  gh.singleton<_i189.AppCubit>(() => _i189.AppCubit());
  return getIt;
}
