import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:fl_news/src/core/json_converter.dart';
import 'package:fl_news/src/data/remote/response/news_response.dart';
import 'package:fl_news/src/data/remote/services/news_service.dart';
import 'package:http/io_client.dart' as http;
import 'package:injectable/injectable.dart';

final class NetworkClient extends ChopperClient {
  final HttpClient _httpClient;

  NetworkClient(this._httpClient)
      : super(
    baseUrl: Uri.parse('https://newsapi.org/v2'),
    converter: JsonSerializableConverter(
      {
        NewsResponse: (json) => NewsResponse.fromJson(json),
      },
    ),
    interceptors: [HttpLoggingInterceptor()],
    client: http.IOClient(_httpClient),
    services: [
      NewsService.create()
    ]
  );
}

final httpClient = HttpClient()
  ..connectionTimeout = const Duration(seconds: 200);
