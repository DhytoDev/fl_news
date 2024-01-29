import 'package:auto_route/auto_route.dart';
import 'package:fl_news/src/di/injection.dart';
import 'package:fl_news/src/presentation/splash/authentication_bloc.dart';
import 'package:fl_news/src/presentation/splash/authentication_event.dart';
import 'package:fl_news/src/presentation/splash/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../route/router.dart';

@RoutePage()
class SplashScreen extends StatelessWidget implements AutoRouteWrapper {
  const SplashScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (c) =>
          getIt<AuthenticationBloc>()..add(GetAuthenticationStatusEvent()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    const String assetName = 'images/magnus.svg';

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          switch (state.authState) {
            case null:
            case AuthState.unauthenticated:
              context.router.replace(const LoginRoute());
              break;
            case AuthState.authenticated:
              context.router.replace(const RootRoute());
              break;
          }
        });
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                assetName,
                semanticsLabel: 'Magnus Digital Logo',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width / 2,
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
