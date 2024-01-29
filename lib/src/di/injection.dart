import 'package:chopper/chopper.dart';
import 'package:fl_news/src/core/network_client.dart';
import 'package:fl_news/src/data/repositories/user_repository.dart';
import 'package:fl_news/src/domain/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../domain/model/user.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  asExtension: true,
  initializerName: 'init',
  preferRelativeImports: true,
)
Future<void> configureInjection() async {
  getIt.init(environment: Environment.prod);

  getIt.registerLazySingleton<ChopperClient>(() => NetworkClient(httpClient));

  final Map<String, List<User>> usersForPassword = {
    "magnusaja": [User.users[0]],
    "dhyto": [User.users[1]]
  };

  getIt.registerLazySingleton<IUserRepository>(
      () => InMemoryUserRepository(usersForPassword, getIt()));
}
