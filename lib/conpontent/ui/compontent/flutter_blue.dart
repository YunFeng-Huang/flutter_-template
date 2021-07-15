import 'package:flutter/services.dart';

class FlutterBlue {
  //这里的参数名要和底层原生的申明的参数名一样
  static const MethodChannel methodChannel = MethodChannel('samples.flutter.io/bluetooth');

  Future<void> openBlueTooth() async {
    //打开蓝牙
    return await methodChannel.invokeMethod('openBuleTooth');
  }

  Future<void> getBlueTooth() async {
    //检测蓝牙
    return await methodChannel.invokeMethod('getBuleTooth');
  }
}
