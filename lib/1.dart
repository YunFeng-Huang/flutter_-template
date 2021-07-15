// import 'package:flutter_blue/flutter_blue.dart';
// FlutterBlue flutterBlue = FlutterBlue.instance;
// void _blueOpenDoor (Map list) async {
//   var isFirstScan = true;
//   var isConnect = false;
//   _delayed?.cancel();
//   # // 自定义loading
//   cancel = BotToast.showCustomLoading(
//       ignoreContentClick: true,
//       toastBuilder: (cancelFunc) {
//         return Loading();
//       }
//   );
//   blueList.forEach((scanResult) async {
//     # // if (scanResult.device.name == '201901012212') {
//     if (scanResult.device.name == list["macAddress"]) {
//       print('蓝牙设备门禁正在连接~~~~~~~~~');
//       await scanResult.device.disconnect();
//       await scanResult.device.connect();
//       isConnect = true;
//       print('蓝牙设备门禁连接成功~~~~~~~~~');
//       # // List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;
//       // if(connectedDevices.contains(scanResult.device)) {
//       //   // TO DO
//       // }
//       List<BluetoothService> services = await scanResult.device.discoverServices();
//       # //遍历蓝牙设备对列表
//       services.forEach((service) async {
//         if (service.uuid.toString().toUpperCase().substring(4, 8) == 'FFF0') {
//           var characteristics = service.characteristics;
//           for(BluetoothCharacteristic c in characteristics) {
//             if (c.uuid.toString().toUpperCase().substring(4, 8) == 'FFF1') {
//               # // 开门指令
//               print('蓝牙设备门禁服务匹配成功~~~~~~~~~');
//               await c.write([0x30, 0x10, 0x02, 0x03 ...........]);
//               print('蓝牙设备门禁指令发送成功~~~~~~~~~');
//               # // 开门声音
//               cancel();
//               _delayed?.cancel();
//               showOpenDoorDialog(1, list['doorControlName']);
//               await _audioPlayer.play("https://qinlin-resource.oss-cn-zhangjiakou.aliyuncs.com/wechat/opendoor.mp3");
//               await scanResult.device.disconnect();
//             }
//             # // 监听门禁返回 并断开连接
//             if (c.uuid.toString().toUpperCase().substring(4, 8) == 'FFF2') {
//               # // List<int> value = await c.read();
//               # // print('88888888888888888888888$value');
//               await c.setNotifyValue(true);
//               notifySubscription = c.value.listen((value) async {
//                 print('88888888888888888888888$value');
//                 cancel();
//                 await scanResult.device.disconnect();
//                 notifySubscription.cancel();
//               });
//             }
//           }
//         }
//       });
//       # // 获取设备连接状态
//       stateSubscription = scanResult.device.state.listen((s) async {
//         print('连接状态连接状态$s');
//         switch (s) {
//         # // 蓝牙连接成功
//         case BluetoothDeviceState.connected:
//         isFirstScan = true;
//         break;
//         case BluetoothDeviceState.disconnected:
//         if (!isFirstScan){
//         cancel();
//         _delayed?.cancel();
//         print('蓝牙设备门禁连接失败~~~~~~~~~');
//         BotToast.showText(
//         text: '蓝牙设备连接失败，请稍后再试',
//         align: Alignment(0, 0.1),
//         onlyOne: true,
//         duration: Duration(milliseconds: 2000),
//         contentPadding: const EdgeInsets.all(15.0),
//         );
//         }
//         break;
//         default:
//         cancel();
//         _delayed?.cancel();
//         print('蓝牙设备门禁连接失败~~~~~~~~~');
//         BotToast.showText(
//         text: '蓝牙设备连接失败，请稍后再试',
//         align: Alignment(0, 0.1),
//         onlyOne: true,
//         duration: Duration(milliseconds: 2000),
//         contentPadding: const EdgeInsets.all(15.0),
//         );
//         break;
//       }
//       });
//     }
//   });
//   _delayed = Timer.periodic(new Duration(seconds: 15), (timer) {
//     cancel();
//     if (!isConnect) {
//       BotToast.showText(
//         text: '该门禁蓝牙信号较弱，请稍后再试',
//         align: Alignment(0, 0.1),
//         onlyOne: true,
//         duration: Duration(milliseconds: 2000),
//         contentPadding: const EdgeInsets.all(15.0),
//       );
//     }
//     _delayed?.cancel();
//   });
//
// }
// # // 15s 定时扫描蓝牙
// Future<dynamic> _scanBlue () async {
//   flutterBlue.state.listen((s) {
//     if (s == BluetoothState.on) {
//       setState(() {
//         _isOpenBlue = true;
//       });
//       FlutterBlue.instance.stopScan();
//       # // 立即执行一次
//       _initScan();
//       _timer = Timer.periodic(new Duration(seconds: 20), (timer) {
//         setState(() {
//           blueList = [];
//         });
//         scanSubscription = flutterBlue.scan().listen((scanResult) async {
//           if (!blueList.contains(scanResult)) {
//             setState(() {
//               blueList.add(scanResult);
//             });
//           }
//         });
//         Future.delayed(Duration(seconds: 10), () {
//           FlutterBlue.instance.stopScan();
//           scanSubscription?.cancel();
//         });
//       });
//     } else {
//       _timer?.cancel();
//       if (!_isOpenBlue) {
//         final snackBar = new SnackBar(
//           content: new Text('如需要蓝牙开门，请先前往手机设置开启蓝牙'),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 3),
//           action: SnackBarAction(
//             textColor: Colors.white,
//             label: '关闭',
//             onPressed: () {},
//           ),
//         );
//         _scaffoldkey.currentState.showSnackBar(snackBar);
//       }
//     }
//   });
// }
// # // 初始执行扫描
// void _initScan () {
//   setState(() {
//     blueList = [];
//   });
//   scanSubscription = flutterBlue.scan().listen((scanResult) async {
//     if (!blueList.contains(scanResult)) {
//       setState(() {
//         blueList.add(scanResult);
//       });
//     }
//   });
//   Future.delayed(Duration(seconds: 10), () {
//     FlutterBlue.instance.stopScan();
//     scanSubscription?.cancel();
//   });
// }
