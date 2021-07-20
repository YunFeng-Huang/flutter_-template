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

  static pushNamed(v, {callback, newContext}) {
    return Navigator.pushNamed(newContext ?? context, routeToString(v)).then((value) => callback?.call(value));
  }

  static pop([newContext]) async {
    return canPop() ? Navigator.pop(newContext ?? context) : null;
  }

  /// 能否返回 */
  static bool canPop({newContext}) {
    return Navigator.canPop(newContext ?? context);
  }

  /// 替换路由 */
  static void pushReplacementNamed(String path, {arguments, newContext, callback}) {
    Navigator.of(newContext ?? context).pushReplacementNamed(path, arguments: arguments).then((value) {
      callback?.call(value);
    });
  }
}
