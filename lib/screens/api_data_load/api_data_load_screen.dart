import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/screens/api_data_load/single_movie_list_screen.dart';
import 'package:flutter_bloc_pattern_example/screens/api_data_load/stack_movie_list_screen.dart';

class ApiDataLoadScreen extends StatelessWidget {
  const ApiDataLoadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Data Load Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SingleMovieListScreen(),
                  ),
                );
              },
              child: const Text('Single Data Load Example'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const StackMovieListScreen(),
                  ),
                );
              },
              child: const Text('Stack Data Load Example'),
            ),
          ],
        ),
      ),
    );
  }
}
