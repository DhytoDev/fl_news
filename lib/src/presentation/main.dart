import 'package:fl_news/src/domain/usecases/get_top_headlines.dart';
import 'package:fl_news/src/presentation/news/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/di/injection.dart';
import 'src/domain/model/article.dart';

void main() async {
  await configureInjection();
  runApp(const MyApp());
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  late PageController _pageController;

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
    // context.go(router.[index].path);
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: const [
          NewsPage(),
          NewsPage(),
          NewsPage(),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RootPage(),
      // routeInformationParser: router.routeInformationParser,
      // routerDelegate: router.routerDelegate,
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsCubit(getIt<GetTopHeadlines>())..fetchTopHeadlines("us"),
      child: const NewsContent(),
    );
  }
}

class NewsContent extends StatelessWidget {
  const NewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, UiState<List<Article>>>(
      listener: (context, state) {},
      builder: (context, state) {
        return switch (state) {
          InitialState() => const CircularProgressIndicator(),
          LoadingState() => const CircularProgressIndicator(),
          SuccessState<List<Article>>() => NewsList(articles: state.data),
          ErrorState() => Text(state.message ?? ''),
        };
      },
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    debugPrint(articles.map((e) => e.title).toString());

    return Container();
  }
}
