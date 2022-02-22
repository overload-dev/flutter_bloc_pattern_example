import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern_example/common/util.dart';
import 'package:flutter_bloc_pattern_example/screens/secure_storage/main_screen.dart';
import 'package:flutter_bloc_pattern_example/screens/secure_storage/register_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  late TextEditingController _userEmailCtrl;
  late TextEditingController _userPasswordCtrl;

  @override
  void initState() {
    super.initState();
    _userEmailCtrl = TextEditingController(text: '');
    _userPasswordCtrl = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _userEmailCtrl.dispose();
    _userPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              _buildEmailWidget(),
              const SizedBox(height: 8.0),
              _buildPasswordWidget(),
              _buildLoginButton(context),
              const Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailWidget() {
    return TextFormField(
      controller: _userEmailCtrl,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          labelText: "Email",
          border: OutlineInputBorder()),
    );
  }

  Widget _buildPasswordWidget() {
    return TextFormField(
      controller: _userPasswordCtrl,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.vpn_key_rounded),
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () => isLoading ? null : _loginCheck(),
        child: Text(
          isLoading ? 'login in.....' : 'login',
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          primary: Colors.purple,
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account ?'),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const RegisterScreen();
                },
              ),
            );
          },
          child: const Text('register'),
        )
      ],
    );
  }

  void _loginCheck() async {
    if (kDebugMode) {
      print('_userEmailCtrl.text : ${_userEmailCtrl.text}');
      print('_userPasswordCtrl.text : ${_userPasswordCtrl.text}');
    }

    const storage = FlutterSecureStorage();

    String? storagePass = await storage.read(key: _userEmailCtrl.text);

    if (storagePass != null &&
        storagePass != '' &&
        storagePass == _userPasswordCtrl.text) {
      if (kDebugMode) print('storagePass : $storagePass');
      String? userNickName =
          await storage.read(key: '${_userEmailCtrl.text}_$storagePass');

      storage.write(key: userNickName!, value: STATUS_LOGIN);

      if (kDebugMode) print('로그인 성공');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const MainScreen();
          },
        ),
      );
    } else {
      if (kDebugMode) print('로그인 실패');

      showToast('아이디가 존재하지 않거나 비밀번호가 맞지 않습니다.');
    }
  }
}
