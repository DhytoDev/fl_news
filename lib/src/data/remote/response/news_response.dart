import 'package:json_annotation/json_annotation.dart';

import 'article.dart';

part 'news_response.g.dart';

@JsonSerializable(createToJson: false)
class NewsResponse {
  final String status;
  final int totalResults;
  final List<ArticleDto> articles;

  NewsResponse({
    required this.status,
    this.totalResults = 0,
    this.articles = const <ArticleDto>[],
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);
}
