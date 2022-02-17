import 'package:flutter_bloc_pattern_example/src/models/user_model.dart';
import 'package:flutter_bloc_pattern_example/src/resources/user_api_provider.dart';

class Repository {
  final userApiProvider = UserApiProvider();

  Future<UserModel> fetchUser(int id) => userApiProvider.fetchUser(id);
}
