import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/screens/main_screen.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogging();

  runApp(const App());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((rec) {
    if (kDebugMode) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
  });
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //
    //   home: LoadingNext(),
    // );
    return MaterialApp(
      title: 'Movie Listings',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}
