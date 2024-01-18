import 'package:flutter/material.dart';

void showSnackBar(BuildContext cxt, String content){
  ScaffoldMessenger.of(cxt).showSnackBar(
    SnackBar(
      content: Text(content),
      showCloseIcon: true,
    )
  );
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good morning';
  }
  if (hour < 17) {
    return 'Good afternoon';
  }
  return 'Good evening';
}

bool isValidEmail(email){
  if (RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return true;
  } else {
    return false;
  }

}