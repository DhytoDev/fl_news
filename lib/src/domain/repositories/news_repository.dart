import 'package:dartz/dartz.dart';
import 'package:fl_news/src/core/exceptions.dart';
import 'package:fl_news/src/domain/model/article.dart';

abstract interface class INewsRepository {
  Future<Either<NetworkException, List<Article>>> getTopHeadlines(
      {String country = "id"});
}
