import 'package:flutter/material.dart';
import 'package:github_clone/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget setHeight(double value) {
  return SizedBox(
    height: value,
  );
}

Widget setWidth(double value) {
  return SizedBox(
    width: value,
  );
}

fetchUserToken() {
  return storage.read("token");
}

toastify(String message) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0);
}

Widget loader() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.black,
    ),
  );
}
