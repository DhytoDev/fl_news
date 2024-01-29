import 'package:dartz/dartz.dart';
import 'package:fl_news/src/core/exceptions.dart';
import 'package:fl_news/src/data/remote/response/article.dart';
import 'package:fl_news/src/data/remote/services/news_service.dart';
import 'package:fl_news/src/domain/model/article.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/news_repository.dart';

@LazySingleton(as: INewsRepository)
final class NewsRepository implements INewsRepository {
  final NewsService _newsService;

  NewsRepository(this._newsService);

  @override
  Future<Either<NetworkException, List<Article>>> getTopHeadlines(
      {String country = "id"}) async {
    final response = await _newsService.fetchTopHeadlines(
        country, '3cd3b3dd843b47ec8215ae990e314042');

    if (response.isSuccessful) {
      final articlesResponse = response.body?.articles ?? List.empty();

      final articles = articlesResponse
          .map((articleDto) => _articleDtoMapper(articleDto))
          .toList();

      return right(articles);
    }

    return left(NetworkException(status: response.statusCode));
  }

  Article _articleDtoMapper(ArticleDto dto) {
    return Article(
      source: dto.source?.name,
      author: dto.author,
      title: dto.title,
      description: dto.description,
      url: dto.url,
      urlToImage: dto.urlToImage,
      publishedAt: dto.publishedAt,
      content: dto.content,
    );
  }
}
