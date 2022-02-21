// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lists _$ListsFromJson(Map<String, dynamic> json) => Lists(
      id: json['id'] as int,
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => ListResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListsToJson(Lists instance) => <String, dynamic>{
      'id': instance.id,
      'page': instance.page,
      'results': instance.results,
    };
