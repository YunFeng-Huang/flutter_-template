import 'package:flutter/cupertino.dart';
import 'package:flutter_huanhu/page/home.dart';
import 'package:flutter_huanhu/page/login.dart';

import 'main.dart';

enum routes { home, login }

Map routeJson = {
  routes.home: {'name': 'home', 'route': HomePage()}, //首页
  routes.login: {'name': 'login', 'route': LoginPage()} //登录页
};

String routeToString(v) {
  return routeJson[v]['name'];
}

class Routers {
  static BuildContext? get context => navigatorKey.currentState?.context;
  static Map<String, Widget Function(BuildContext)> map() {
    Map<String, Widget Function(BuildContext)> obj = {};
    routeJson.forEach((key, value) {
      obj.addAll({value['name']: (context) => value['route']});
    });
    return obj;
  }

  static pushNamed(v) {
    return Navigator.pushNamed(context!, routeToString(v));
  }
}
