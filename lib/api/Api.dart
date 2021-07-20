import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_huanhu/conpontent/ui/my_toast.dart';
import 'package:flutter_huanhu/utils/local_storage.dart';
import 'package:flutter_huanhu/utils/log_util.dart';

import '../config.dart';

class Api {
  static final debug = Config.debug;
  static int _merchantId = Config.merchantId;
  static String baseUrl = Config.baseUrl;

  /// 版本号
  static String version = Config.version;

  // ignore: argument_type_not_assignable
  static BaseOptions _options = BaseOptions(
    baseUrl: Config.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.json,
    headers: {
      'merchantId': _merchantId,
      "device": Platform.isIOS ? "iOS" : "Android",
      "version": version,
      "client-type": '',
      "user-agent": '',
      "token": '',
    },
  );
  static late Dio dio;
  static request(String uri, {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters, type, Options? setOption, method = 'post'}) async {
    String token = await getToken();
    dio = new Dio(_options);
    _options..headers['token'] = token;
    _interceptors(dio);
    return dio.request<Map<String, dynamic>>(uri, queryParameters: queryParameters, data: data, options: setOption);
  }

  static _interceptors(dio) {
    dio.interceptors
      ..add(InterceptorsWrapper(onRequest: (options, handler) {
        // return handler.resolve( Response(data:"xxx"));
        // return handler.reject( DioError(message: "eh"));
        return handler.next(options);
      }, onResponse: (response, handler) {
        dio?.clear();
        dio = null;
        _log(response);
        _response(response);
        return handler.next(response);
      }, onError: (DioError e, handler) {
        dio?.clear();
        dio = null;
        formatError(e);
        return;
      }));
    // ..add(
    //   LogInterceptor(
    //     request: false,
    //     requestBody: false,
    //     requestHeader: false,
    //     responseHeader: false,
    //     responseBody: false,
    //   ),
    // ); //Open log;
  }

  static _response(res) {
    return res.data;
  }
}

// /获取授权token
getToken() async {
  String token = await PersistentStorage().getStorage('token');
  return token;
}

/*
   * error统一处理
   */
void formatError(DioError e) {
  Log.d(e, 'formatError');
  String str;
  if (e.type == DioErrorType.connectTimeout) {
    // It occurs when url is opened timeout.
    str = ("连接超时");
  } else if (e.type == DioErrorType.sendTimeout) {
    // It occurs when url is sent timeout.
    str = ("请求超时");
  } else if (e.type == DioErrorType.receiveTimeout) {
    //It occurs when receiving timeout
    str = ("响应超时");
  } else if (e.type == DioErrorType.response) {
    // When the server response, but with a incorrect status, such as 404, 503...
    str = ("出现异常");
  } else if (e.type == DioErrorType.cancel) {
    // When the request is cancelled, dio will throw a error with this type.
    str = ("请求取消");
  } else {
    //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
    // str = e.toString();

    // throttle(() {
    //   return showConfirmDialog('当前网络连接故障，请您稍后再试', cancelTitle: null, title: '网络故障');
    // });
    return;
  }

  showToast('网络不稳定，$str');
  // dingTalk(str, uri, params, str);
}

void _log(response) {
  print('');
  print('------------------------------------------start-----------------------------------------------------------');
  print('<net uri>---------->${response.requestOptions.uri}');
  try {
    print('<net params>------->${jsonEncode(response.requestOptions.data)}');
  } catch (error) {
    print('<net params>------->$error');
  }
  print('<net headers>------>${response.requestOptions.headers}');

  print("<net response>----->${response.data}");
  print('------------------------------------------end-------------------------------------------------------------');
  print('');
}
