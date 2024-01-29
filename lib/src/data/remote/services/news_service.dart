import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import '../response/news_response.dart';

part 'news_service.chopper.dart';

@lazySingleton
@ChopperApi()
abstract class NewsService extends ChopperService {
  @factoryMethod
  static NewsService create([ChopperClient? chopperClient]) =>
      _$NewsService(chopperClient);

  @Get(path: '/top-headlines')
  Future<Response<NewsResponse?>> fetchTopHeadlines(
    @Query('country') String country,
    @Query('apiKey') String apiKey,
  );
}
