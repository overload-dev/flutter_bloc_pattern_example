
import 'package:flutter_bloc_pattern_example/models/list_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lists.g.dart';
@JsonSerializable()
class Lists{
  int id;
  int page;
  List<ListResult> results;

  Lists({required this.id, required this.page, required this.results});

  factory Lists.fromJson(Map<String, dynamic> json) => _$ListsFromJson(json);
  Map<String, dynamic> toJson() => _$ListsToJson(this);

}