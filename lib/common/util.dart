import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String USER_NICK_NAME = 'USER_NICK_NAME';
const String STATUS_LOGIN = 'STATUS_LOGIN';
const String STATUS_LOGOUT = 'STATUS_LOGOUT';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: '  $message  ',
    backgroundColor: Colors.black,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}
