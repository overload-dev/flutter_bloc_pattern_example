import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/src/blocs/user_bloc.dart';
import 'package:flutter_bloc_pattern_example/src/models/user_model.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    bloc.fetchUser(4);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: StreamBuilder(
        stream: bloc.user,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return _buildUser(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _buildUser(UserModel userModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('id: '),
            Text('${userModel.id}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('name: '),
            Text(userModel.name),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('username: '),
            Text(userModel.username),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('email: '),
            Text(userModel.email),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('address: '),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('street: '),
                    Text(userModel.address.street),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('suite: '),
                    Text(userModel.address.suite),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('city: '),
                    Text(userModel.address.city),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('zipcode: '),
                    Text(userModel.address.zipcode),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('geo: '),
                    Text(
                        '${userModel.address.geo.lat} / ${userModel.address.geo.lng}'),
                  ],
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('phone: '),
            Text(userModel.phone),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('website: '),
            Text(userModel.website),
          ],
        ),
      ],
    );
  }
}
