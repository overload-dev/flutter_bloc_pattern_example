import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/src/models/user_model.dart';
import 'package:flutter_bloc_pattern_example/src/resources/user_api_provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  int offset = 1;
  int count = 10;

  List<UserModel> userList = [];

  bool _isInitialLoading = true;

  final UserApiProvider _userApiProvider = UserApiProvider();

  @override
  void initState() {
    super.initState();
  }

  void initialUserListLoading() async {
    List<UserModel> _userList =
        await _userApiProvider.fetchUserList(offset, count);

    setState(() {
      userList.addAll(_userList);
      offset += count;
      _isInitialLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
