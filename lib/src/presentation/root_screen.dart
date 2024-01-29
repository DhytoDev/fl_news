import 'package:auto_route/auto_route.dart';
import 'package:countries_flag/countries_flag.dart';
import 'package:fl_news/src/presentation/home/home_screen.dart';
import 'package:fl_news/src/presentation/news/news_bloc.dart';
import 'package:fl_news/src/presentation/profile/profile_screen.dart';
import 'package:fl_news/src/presentation/splash/authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/injection.dart';
import '../domain/usecases/get_top_headlines.dart';
import 'news/news_screen.dart';
import 'splash/authentication_bloc.dart';

@RoutePage()
class RootPage extends StatefulWidget implements AutoRouteWrapper {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<NewsCubit>()..fetchTopHeadlines("id"),
      child: this,
    );
  }
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  late PageController _pageController;
  String _flag = Flags.indonesia;
  Locale locale = const Locale("id");

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magnus News'),
        elevation: 5,
        actions: [
          if (_currentIndex == 1)
            InkWell(
              onTap: () {
                if (_flag == Flags.indonesia) {
                  setState(() {
                    _flag = Flags.unitedStatesOfAmerica;
                    locale = const Locale('us');
                  });
                } else {
                  setState(() {
                    _flag = Flags.indonesia;
                    locale = const Locale('id');
                  });
                }

                context.read<NewsCubit>().fetchTopHeadlines(locale.toString());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CountriesFlag(
                  _flag,
                  width: 20,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedIndex: _currentIndex,
        onDestinationSelected: _onItemTapped,
      ),
      body: BlocProvider<AuthenticationBloc>(
        create: (c) =>
            getIt<AuthenticationBloc>()..add(GetAuthenticationStatusEvent()),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() => _currentIndex = index),
          children: [
            HomeScreen(
              onReadNowTapped: () {
                _pageController.jumpToPage(1);
              },
            ),
            const NewsScreen(),
            const ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
