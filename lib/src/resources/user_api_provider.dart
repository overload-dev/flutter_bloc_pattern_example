import 'dart:convert';

import 'package:flutter_bloc_pattern_example/src/models/user_model.dart';
import 'package:http/http.dart' show Client;

class UserApiProvider {
  Client client = Client();

  Future<UserModel> fetchUser(int id) async {
    final String url = 'https://jsonplaceholder.typicode.com/users/$id';

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<UserModel>> fetchUserList(int offset, int count) async {
    final String url =
        'https://jsonplaceholder.typicode.com/users?offset=$offset/$count';

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<UserModel> list = json.decode(response.body);

      return json
          .decode(response.body)
          .map<UserModel>((item) => UserModel.fromJson(item));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
