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
  static BuildContext? get _context => navigatorKey.currentState?.context;
  static Map<String, Widget Function(BuildContext)> map() {
    Map<String, Widget Function(BuildContext)> obj = {};
    routeJson.forEach((key, value) {
      obj.addAll({value['name']: (context) => value['route']});
    });
    return obj;
  }

  static pushNamed(v, {callback, context}) {
    return Navigator.pushNamed(context ?? _context, routeToString(v)).then((value) => callback?.call(value));
  }

  static pop([context]) async {
    return canPop() ? Navigator.pop(context ?? _context) : null;
  }

  /// 能否返回 */
  static bool canPop({context}) {
    return Navigator.canPop(context ?? _context);
  }

  /// 替换路由 */
  static void pushReplacementNamed(String path, {arguments, context, callback}) {
    Navigator.of(context ?? _context).pushReplacementNamed(path, arguments: arguments).then((value) {
      callback?.call(value);
    });
  }
}
