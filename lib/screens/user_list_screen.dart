import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/src/models/user_model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  int offset = 1;
  int count = 10;

  List<UserModel> userList = [];

  bool isLoading = true;


  @override
  void initState() {
    super.initState();






  }






  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
