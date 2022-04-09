import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String text) {
  Fluttertoast.showToast(msg: text, fontSize: 15, gravity: ToastGravity.CENTER);
}
