import 'package:flutter_bloc_pattern_example/src/models/address_model.dart';
import 'package:flutter_bloc_pattern_example/src/models/company_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int id;
  String name;
  String username;
  String email;
  AddressModel address;
  String phone;
  String website;
  CompanyModel company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
