import 'package:dartz/dartz.dart';
import 'package:fl_news/src/core/exceptions.dart';
import 'package:fl_news/src/domain/model/article.dart';
import 'package:fl_news/src/domain/repositories/news_repository.dart';
import 'package:fl_news/src/domain/usecases/get_top_headlines.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockNewsRepository extends Mock implements INewsRepository {}

class MockArticles extends Mock implements List<Article> {}

void main() {
  late MockNewsRepository newsRepository;
  late GetTopHeadlines sut;

  setUp(() {
    newsRepository = MockNewsRepository();
    sut = GetTopHeadlines(newsRepository);
  });

  test('fetch top headlines successfully', () async {
    final articles = MockArticles();

    when(() => newsRepository.getTopHeadlines(country: "id"))
        .thenAnswer((_) async => right(articles));

    verifyZeroInteractions(newsRepository);

    final result = await sut.execute("id");

    verify(() => newsRepository.getTopHeadlines(country: "id"));

    expect(result, right(articles));
  });

  test('fetch top headlines returns an exception', () async {
    const networkException = NetworkException(status: 500);

    when(() => newsRepository.getTopHeadlines(country: "id"))
        .thenAnswer((_) async => left(networkException));

    verifyZeroInteractions(newsRepository);

    final result = await sut.execute("id");

    verify(() => newsRepository.getTopHeadlines(country: "id"));

    expect(result, left(networkException));
  });
}
