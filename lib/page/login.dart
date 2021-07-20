import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/conpontent/ui/css.dart';
import 'package:flutter_huanhu/conpontent/ui/html/XButtom.dart';
import 'package:flutter_huanhu/conpontent/ui/html/XInput.dart';
import 'package:flutter_huanhu/conpontent/ui/index.dart';
import 'package:flutter_huanhu/utils/local_storage.dart';

import '../routes_config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = 'text';
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('环湖观光车运营系统'),
            XInput(
              controller: nameController,
              label: '账号',
              labelWidth: 40.w,
              hintText: '请输入账号',
              validator: 'name',
              required: true,
              onChanged: (v) {
                print(v);
              },
            ),
            XInput(label: '密码', labelWidth: 40.w, hintText: '请输入密码'),
            XButton(
              '登录',
              width: 200.w,
              height: 10.w,
              borderSize: 1.w,
              callback: () {
                print(111);
                PersistentStorage().setStorage('token', 'value');
                Routers.pushNamed(routes.home);
              },
            ).margin(top: 20.w)
          ],
        ).paddingAll(20.w).background(width: 400.w, height: 400.w, border: 4.w, borderColor: ThemeColor.red, radius: 10.w),
      ),
    );
  }
}
