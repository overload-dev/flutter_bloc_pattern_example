import 'package:json_annotation/json_annotation.dart';

part 'list_result.g.dart';

@JsonSerializable()
class ListResult {
  String description;

  @JsonKey(name: 'favorite_count')
  int favoriteCount;
  int id;
  @JsonKey(name: 'item_count')
  int itemCount;
  @JsonKey(name: 'iso_639_1')
  String iso6391;

  @JsonKey(name: 'list_type')
  String listType;
  String name;

  @JsonKey(name: 'posterPath')
  String posterPath;

  ListResult({
    required this.description,
    required this.favoriteCount,
    required this.id,
    required this.itemCount,
    required this.iso6391,
    required this.listType,
    required this.name,
    this.posterPath = '',
  });

  factory ListResult.fromJson(Map<String, dynamic> json) =>
      _$ListResultFromJson(json);

  Map<String, dynamic> toJson() => _$ListResultToJson(this);
}
