import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/src/ui/user_list.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: UserList(),
      ),
    );
  }
}
