import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../route/router.dart';
import '../splash/authentication_bloc.dart';
import '../splash/authentication_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onReadNowTapped,
  });

  final VoidCallback onReadNowTapped;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.authState == AuthState.authenticated) {
          final user = state.user!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Welcome, ${user.userName}!',
                    textAlign: TextAlign.center,
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                ),
                Text(
                  'Magnus News adalah aplikasi yang menyajikan berita teraktual dan terpercaya.',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                FilledButton(
                  onPressed: onReadNowTapped,
                  child: const Text('Baca Sekarang'),
                )
              ],
            ),
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
