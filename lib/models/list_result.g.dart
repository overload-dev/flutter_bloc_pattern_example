// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResult _$ListResultFromJson(Map<String, dynamic> json) => ListResult(
      description: json['description'] as String,
      favoriteCount: json['favorite_count'] as int,
      id: json['id'] as int,
      itemCount: json['item_count'] as int,
      iso6391: json['iso_639_1'] as String,
      listType: json['list_type'] as String,
      name: json['name'] as String,
      posterPath: json['posterPath'] as String? ?? '',
    );

Map<String, dynamic> _$ListResultToJson(ListResult instance) =>
    <String, dynamic>{
      'description': instance.description,
      'favorite_count': instance.favoriteCount,
      'id': instance.id,
      'item_count': instance.itemCount,
      'iso_639_1': instance.iso6391,
      'list_type': instance.listType,
      'name': instance.name,
      'posterPath': instance.posterPath,
    };
