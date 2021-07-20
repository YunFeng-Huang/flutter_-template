import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/conpontent/ui/css.dart';
import 'package:flutter_huanhu/conpontent/ui/index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('环湖观光车运营系统'),
            XInput(label: '账号', hintText: 'aa'),
            XInput(label: '密码', hintText: 'aa'),
          ],
        ).background(width: 300.w, height: 300.w, color: Colors.red, radius: 10.w),
      ),
    );
  }
}
