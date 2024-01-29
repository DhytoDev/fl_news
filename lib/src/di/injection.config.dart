// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chopper/chopper.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/local/user_prefs.dart' as _i5;
import '../data/remote/services/news_service.dart' as _i6;
import '../data/repositories/news_repository.dart' as _i11;
import '../domain/repositories/news_repository.dart' as _i10;
import '../domain/repositories/user_repository.dart' as _i4;
import '../domain/usecases/get_top_headlines.dart' as _i12;
import '../domain/usecases/sign_in.dart' as _i8;
import '../presentation/news/news_bloc.dart' as _i13;
import '../presentation/sign_in/sign_in_bloc.dart' as _i9;
import '../presentation/splash/authentication_bloc.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AuthenticationBloc>(
        () => _i3.AuthenticationBloc(gh<_i4.IUserRepository>()));
    gh.lazySingleton<_i5.IUserPreferences>(() => _i5.UserPreferencesImpl());
    gh.lazySingleton<_i6.NewsService>(
        () => _i6.NewsService.create(gh<_i7.ChopperClient>()));
    gh.factory<_i8.SignIn>(() => _i8.SignIn(gh<_i4.IUserRepository>()));
    gh.factory<_i9.SignInBloc>(() => _i9.SignInBloc(gh<_i8.SignIn>()));
    gh.lazySingleton<_i10.INewsRepository>(
        () => _i11.NewsRepository(gh<_i6.NewsService>()));
    gh.factory<_i12.GetTopHeadlines>(
        () => _i12.GetTopHeadlines(gh<_i10.INewsRepository>()));
    gh.factory<_i13.NewsCubit>(
        () => _i13.NewsCubit(gh<_i12.GetTopHeadlines>()));
    return this;
  }
}
