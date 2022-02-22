import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/common/util.dart';
import 'package:flutter_bloc_pattern_example/screens/secure_storage/login_screen.dart';
import 'package:flutter_bloc_pattern_example/screens/secure_storage/main_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageScreen extends StatefulWidget {
  const SecureStorageScreen({Key? key}) : super(key: key);

  @override
  _SecureStorageScreenState createState() => _SecureStorageScreenState();
}

// splash screen
class _SecureStorageScreenState extends State<SecureStorageScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => _checkUser(context));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.stream,
          size: 80.0,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _checkUser(context) async {
    const storage = FlutterSecureStorage();

    if (kDebugMode) {
      print('${await storage.readAll()}');
    }

    Map<String, String> allStorage = await storage.readAll();

    String statusUser = '';
    if (allStorage.isNotEmpty) {
      allStorage.forEach((key, value) {
        if (kDebugMode) {
          print('key: $key, value: $value');
        }
        if (value == STATUS_LOGIN) statusUser = key;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }

    if (statusUser != '') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainScreen(nickName: statusUser),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }
}
