import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/screens/api_data_load/api_data_load_screen.dart';
import 'package:flutter_bloc_pattern_example/screens/secure_storage/secure_storage_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // RegExp nameRegex = RegExp(r'^[\w.@+-]+$');
    // RegExp emailRegex = RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}$');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Network & Data Work Examples'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ApiDataLoadScreen(),
                  ),
                );
              },
              child: const Text('API Data Load Examples'),
            ),
            // Secure Storage Example
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SecureStorageScreen(),
                  ),
                );
              },
              child: const Text('Secure Storage Example'),
            )
          ],
        ),
      ),
    );
  }
}
