import 'package:dartz/dartz.dart';
import 'package:fl_news/src/core/usecase.dart';
import 'package:fl_news/src/domain/model/article.dart';
import 'package:fl_news/src/domain/repositories/news_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTopHeadlines extends UseCase<List<Article>, String> {
  final INewsRepository _newsRepository;

  GetTopHeadlines(this._newsRepository);

  @override
  Future<Either<Exception, List<Article>>> execute(String params) {
    return _newsRepository.getTopHeadlines(country: params);
  }
}
