import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.black12,
    title: Image.asset(
      "assets/images/an4.gif",
      height: 40,
    ),
    actions: <Widget>[
      Text(
        "ChatApp",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 150,
      )
    ],
    elevation: 10.0,
    centerTitle: false,
  );
}

InputDecoration textFieldInputDecorationEmail(String hintText) {
  return InputDecoration(
      icon: Icon(Icons.mail),
      labelText: "Email",
      labelStyle: TextStyle(fontSize: 25),
      hintStyle: TextStyle(color: Colors.black),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)));
}

InputDecoration textFieldInputDecorationPassword(String hintText) {
  return InputDecoration(
      icon: Icon(Icons.lock),
      labelText: "Password",
      labelStyle: TextStyle(fontSize: 25),
      hintStyle: TextStyle(color: Colors.black),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)));
}

InputDecoration textFieldInputDecorationName(String hintText) {
  return InputDecoration(
      icon: Icon(Icons.person),
      labelText: "Username",
      labelStyle: TextStyle(fontSize: 25),
      hintStyle: TextStyle(color: Colors.black),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
