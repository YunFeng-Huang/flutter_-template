import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'conpontent/ui/my_custom_app_bar.dart';
import 'conpontent/ui/my_loading.dart';

// ignore: non_constant_identifier_names
_JsBridgeCallback(JsBridge, flutterWebviewPlugin) async {
  print(JsBridge.toString());
  print(JsBridge.data);

  if (JsBridge.method == 'JumpMap') {
    // var data = await HomeApi.getMapMark(JsBridge.data);
    // var str = await MapUtil.gotoAMap(data['mapMarkLatitude'], data['mapMarkLongitude']);
    // if (str.length > 0) {
    //   flutterWebviewPlugin.evalJavascript("JumpMapError('${str}')");
    // } else {
    //   flutterWebviewPlugin.evalJavascript('JumpMapSuccess()');
    // }
  }
}

class WebPage extends StatefulWidget {
  final String webUrl;
  final String? webTitle;
  WebPage({required this.webUrl, this.webTitle});

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> with SingleTickerProviderStateMixin {
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'App',
      onMessageReceived: (JavascriptMessage message) async {
        var JsBridge = JsBridgeUtil.parseJson(message.message);
        _JsBridgeCallback(JsBridge, flutterWebviewPlugin);
      },
    );
  }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  // URL变化监听器
  // ignore: cancel_subscriptions
  late StreamSubscription<String> onUrlChanged;
  // WebView加载状态变化监听器
  // ignore: cancel_subscriptions
  late StreamSubscription<WebViewStateChanged> onStateChanged;

  @override
  void initState() {
    flutterWebviewPlugin.dispose();
    onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      // state.type是一个枚举类型，取值有：WebViewState.shouldStart, WebViewState.startLoad, WebViewState.finishLoad
      print(state.type);
    });
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    flutterWebviewPlugin.close();
    flutterWebviewPlugin.evalJavascript(r'window.location.reload()');
    super.dispose();
  }

  Future<bool> _onBackPressed() async {
    await flutterWebviewPlugin.evalJavascript(r'location.reload()');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: XAppBar(
          title: widget.webTitle ?? '',
          backgroundColor: Colors.white,
          leftCallback: () => _onBackPressed(),
        ),
        body: WebviewScaffold(
          key: scaffoldKey,
          url: widget.webUrl,
          withJavascript: true,
          appCacheEnabled: true,
          clearCache: true,
          // withLocalUrl: true,
          hidden: true,
          allowFileURLs: true,
          initialChild: Center(
            child: Loading(),
          ),
          javascriptChannels: <JavascriptChannel>[
            _alertJavascriptChannel(context),
          ].toSet(),
        ),
      ),
    );
  }
}

class JsBridge {
  String method;
  dynamic data;
  Function success;
  Function error;
  JsBridge(this.method, this.data, this.success, this.error);

  Map toJson() {
    Map map = new Map();
    map["method"] = this.method;
    map["data"] = this.data;
    map["success"] = this.success;
    map["error"] = this.error;
    return map;
  }

  static JsBridge fromMap(Map<String, dynamic> map) {
    JsBridge jsonModel = new JsBridge(map['method'], map['data'], map['success'], map['error']);
    return jsonModel;
  }

  @override
  String toString() {
    return "JsBridge: {method: $method, data: $data, success: $success, error: $error}";
  }
}

class JsBridgeUtil {
  /// 将json字符串转化成对象
  static JsBridge parseJson(String jsonStr) {
    JsBridge jsBridgeModel = JsBridge.fromMap(jsonDecode(jsonStr));
    return jsBridgeModel;
  }
}
