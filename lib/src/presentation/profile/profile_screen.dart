import 'package:auto_route/auto_route.dart';
import 'package:fl_news/src/presentation/route/router.dart';
import 'package:fl_news/src/presentation/splash/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../splash/authentication_bloc.dart';
import '../splash/authentication_event.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.authState == AuthState.authenticated) {
          final user = state.user!;

          return Column(
            children: [
              ListTile(
                title: const Text('First Name'),
                subtitle: Text(user.firstName),
              ),
              ListTile(
                title: const Text('Last Name'),
                subtitle: Text(user.lastName),
              ),
              ListTile(
                title: const Text('Email'),
                subtitle: Text(user.email),
              ),
              ElevatedButton(
                child: const Text('Sign Out'),
                onPressed: () {
                  context.read<AuthenticationBloc>().add(SignOutEvent());
                },
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          context.router.replace(const SplashRoute());
        }
      },
    );
  }
}
