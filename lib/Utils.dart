import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Utils {
  bool _isShowingToast = false;
  void showToast(String msg) {
    if (!_isShowingToast) {
      _isShowingToast = true;
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        webPosition: 'center',
        webBgColor: 'red',
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Future.delayed(Duration(seconds: 3), () {
        _isShowingToast = false;
      });
    }
  }
}