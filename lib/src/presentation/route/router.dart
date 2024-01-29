import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

import '../news_detail/news_detail_screen.dart';
import '../root_screen.dart';
import '../sign_in/sign_in_screen.dart';
import '../splash/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        MaterialRoute(page: SplashRoute.page, initial: true),
        MaterialRoute(page: LoginRoute.page),
        MaterialRoute(page: RootRoute.page),
        MaterialRoute(page: NewsDetailRoute.page),
      ];
}
