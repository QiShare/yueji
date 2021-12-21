import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ToastUtils {
  static showToast(BuildContext context, String msg) {
    Toast.show(msg, context, gravity: Toast.CENTER);
  }
}
