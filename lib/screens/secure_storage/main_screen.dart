import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/common/util.dart';
import 'package:flutter_bloc_pattern_example/screens/secure_storage/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainScreen extends StatefulWidget {
  final String? nickName;

  const MainScreen({Key? key, this.nickName}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const storage = FlutterSecureStorage();

  String? nickName;

  @override
  void initState() {
    super.initState();
    setState(() {
      nickName = widget.nickName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child:
            Text(nickName == '' || nickName == null ? '' : 'Hello $nickName'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.keyboard_return_rounded),
        onPressed: () => _logout(),
      ),
    );
  }

  void _logout() async {
    Map<String, String> allStorage = await storage.readAll();

    allStorage.forEach((key, value) async {
      if (value == STATUS_LOGIN) {
        await storage.write(key: key, value: STATUS_LOGOUT);
      }
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
