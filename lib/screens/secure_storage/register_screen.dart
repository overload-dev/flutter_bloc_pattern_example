import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/common/util.dart';
import 'package:flutter_bloc_pattern_example/screens/secure_storage/login_screen.dart';
import 'package:flutter_bloc_pattern_example/screens/secure_storage/main_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  late TextEditingController _userNickNameCtrl;
  late TextEditingController _userEmailCtrl;
  late TextEditingController _userPasswordCtrl;

  @override
  void initState() {
    super.initState();

    _userNickNameCtrl = TextEditingController(text: '');
    _userEmailCtrl = TextEditingController(text: '');
    _userPasswordCtrl = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              _buildNickNameWidget(),
              const SizedBox(height: 8.0),
              _buildEmailWidget(),
              const SizedBox(height: 8.0),
              _buildPasswordWidget(),
              const SizedBox(height: 8.0),
              _buildJoinButton(context),
              _buildLoginButton(context),
              const Expanded(flex: 3, child: SizedBox())
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNickNameWidget() {
    return TextFormField(
      controller: _userNickNameCtrl,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle_rounded),
        labelText: 'nickName',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildEmailWidget() {
    return TextFormField(
      controller: _userEmailCtrl,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email),
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordWidget() {
    return TextFormField(
      controller: _userPasswordCtrl,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.vpn_key_rounded),
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildJoinButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          isLoading ? null : _registCheck();
        },
        child: Text(
          isLoading ? 'regist in.....' : 'regist',
          style: const TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          if (!isLoading) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        },
        child: const Text(
          'login Screen',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }

  void _registCheck() async {
    const storage = FlutterSecureStorage();

    if (kDebugMode) {
      print(' ');
      print('await storage.readAll() : ');
      print(await storage.readAll());
      print(' ');
    }

    String userNickName = _userNickNameCtrl.text;
    String userEmail = _userEmailCtrl.text;
    String userPassword = _userPasswordCtrl.text;

    debugPrint(userEmail);

    if (userNickName != '' && userEmail != '' && userPassword != '') {
      String? emailCheck = await storage.read(key: userEmail);

      if (emailCheck == null) {
        storage.write(key: userEmail, value: userPassword);
        storage.write(key: '${userEmail}_$userPassword', value: userNickName);
        storage.write(key: userNickName, value: STATUS_LOGIN);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainScreen(
              nickName: userNickName,
            ),
          ),
        );
      } else {
        showToast('email이 중복됩니다.');
      }
    } else {
      showToast('입력란을 모두 채워주세요');
    }
  }
}
