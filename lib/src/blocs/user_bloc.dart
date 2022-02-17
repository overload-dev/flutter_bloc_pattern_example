import 'package:flutter_bloc_pattern_example/src/models/user_model.dart';
import 'package:flutter_bloc_pattern_example/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repository = Repository();
  final _userFetcher = PublishSubject<UserModel>();

  Stream<UserModel> get user => _userFetcher.stream;

  fetchUser(int id) async {
    UserModel userModel = await _repository.fetchUser(id);
    _userFetcher.sink.add(userModel);
  }

  dispose() {
    _userFetcher.close();
  }
}

final bloc = UserBloc();
