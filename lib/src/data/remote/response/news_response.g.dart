// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int? ?? 0,
      articles: (json['articles'] as List<dynamic>?)
              ?.map((e) => ArticleDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ArticleDto>[],
    );
