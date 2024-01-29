import 'package:auto_route/auto_route.dart';
import 'package:fl_news/src/core/date_time_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/model/article.dart';
import '../route/router.dart';
import '../ui_state.dart';
import 'news_bloc.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NewsContent();
  }
}

class _NewsContent extends StatelessWidget {
  const _NewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, UiState<List<Article>>>(
      builder: (context, state) {
        Widget? body = const SizedBox.shrink();

        switch (state) {
          case InitialState():
            body = const SizedBox.shrink();
          case LoadingState():
            body = const Center(
              child: CircularProgressIndicator(),
            );
          case SuccessState<List<Article>>():
            body = _NewsList(articles: state.data);
          case ErrorState():
            body = Text(state.message ?? '');
        }

        return body;
      },
    );
  }
}

class _NewsList extends StatelessWidget {
  const _NewsList({super.key, required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, i) {
        final article = articles[i];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: _NewsItem(
            article: article,
            onTapped: () {
              context.router.push(NewsDetailRoute(url: article.url!));
            },
          ),
        );
      },
      separatorBuilder: (context, i) {
        return const Divider();
      },
      itemCount: articles.length,
    );
  }
}

class _NewsItem extends StatelessWidget {
  const _NewsItem({
    super.key,
    required this.article,
    required this.onTapped,
  });

  final Article article;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTapped,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.author != null) Text(article.author!),
          Row(
            children: [
              Expanded(
                child: Text(
                  article.title ?? '',
                  style: textTheme.titleMedium,
                ),
              ),
              const SizedBox(width: 8),
              Image.network(
                article.urlToImage ?? '',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 3,
                errorBuilder: (context, e, s) {
                  return SvgPicture.asset(
                    'images/magnus.svg',
                    semanticsLabel: 'Magnus Digital Logo',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 4,
                  );
                },
                loadingBuilder: (context, child, chunk) {
                  bool loaded = chunk?.cumulativeBytesLoaded ==
                      (chunk?.expectedTotalBytes ?? 0);

                  return child;
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                side: BorderSide(color: Theme.of(context).primaryColor),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                label: Text(
                  article.source ?? '',
                  style: textTheme.bodyMedium,
                ),
              ),
              Text(article.publishedAt!.toDateFormat(toLocal: true))
            ],
          )
        ],
      ),
    );
  }
}
