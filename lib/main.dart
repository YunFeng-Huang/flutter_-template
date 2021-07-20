import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huanhu/api/Api.dart';
import 'package:flutter_huanhu/common/index.dart';
import 'package:flutter_huanhu/page/home.dart';
import 'package:flutter_huanhu/routes_config.dart';
import 'package:flutter_huanhu/utils/log_util.dart';
import 'package:flutter_huanhu/utils/screem.dart';

import 'conpontent/ui/compontent/flutter_blue.dart';

void main() {
  // 强制横屏

  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void _init() async {
    token = await getToken();
    print(token);
    if (!isNotNull(token)) {
      Routers.pushNamed(routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: '环湖app',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: routeToString(routes.home),
      routes: Routers.map(),
      builder: (context, child) {
        ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: false);
        return child!;
      },
      onGenerateRoute: (RouteSettings settings) {
        Log.d(settings, settings.name);
      },
    );
  }
}

//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
//
//   bool _connected = false;
//   BluetoothDevice? _device;
//   String tips = 'no device connect';
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance!.addPostFrameCallback((_) => initBluetooth());
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initBluetooth() async {
//     bluetoothPrint.startScan(timeout: Duration(seconds: 4));
//     bool? isConnected = await bluetoothPrint.isConnected;
//     print(isConnected);
//     bluetoothPrint.state.listen((state) {
//       print('cur device status: $state');
//
//       switch (state) {
//         case BluetoothPrint.CONNECTED:
//           setState(() {
//             _connected = true;
//             tips = 'connect success';
//           });
//           break;
//         case BluetoothPrint.DISCONNECTED:
//           setState(() {
//             _connected = false;
//             tips = 'disconnect success';
//           });
//           break;
//         default:
//           break;
//       }
//     });
//
//     if (!mounted) return;
//
//     if (isConnected ?? false) {
//       setState(() {
//         _connected = true;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('BluetoothPrint example app'),
//         ),
//         body: RefreshIndicator(
//           onRefresh: () => bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                       child: Text(tips),
//                     ),
//                   ],
//                 ),
//                 Divider(),
//                 StreamBuilder<List<BluetoothDevice>>(
//                   stream: bluetoothPrint.scanResults,
//                   initialData: [],
//                   builder: (c, snapshot) => Column(
//                     children: snapshot.data!.map<ListTile>((d) {
//                       // Log.d(d.toJson());
//                       return ListTile(
//                         title: Text(d.name ?? ''),
//                         subtitle: Text(d.address ?? ''),
//                         onTap: () async {
//                           setState(() {
//                             _device = d;
//                           });
//                         },
//                         trailing: _device?.address == d.address
//                             ? Icon(
//                                 Icons.check,
//                                 color: Colors.green,
//                               )
//                             : null,
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Divider(),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
//                   child: Column(
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           OutlinedButton(
//                             child: Text('connect'),
//                             onPressed: () async {
//                               if (_device?.address != null) {
//                                 print(_device?.toJson());
//                                 await bluetoothPrint.destroy();
//                                 await bluetoothPrint.connect(_device!);
//                               } else {
//                                 setState(() {
//                                   tips = 'please select device';
//                                 });
//                                 print('please select device');
//                               }
//                             },
//                           ),
//                           SizedBox(width: 10.0),
//                           OutlinedButton(
//                             child: Text('disconnect'),
//                             onPressed: _connected
//                                 ? () async {
//                                     await bluetoothPrint.disconnect();
//                                     bool? isConnected = await bluetoothPrint.isConnected;
//                                     print(isConnected);
//                                   }
//                                 : null,
//                           ),
//                         ],
//                       ),
//                       OutlinedButton(
//                         child: Text('print receipt(esc)'),
//                         onPressed: _connected
//                             ? () async {
//                                 Map<String, dynamic> config = Map();
//                                 List<LineText> list = [];
//                                 list.add(LineText(type: LineText.TYPE_TEXT, content: 'A Title', weight: 1, align: LineText.ALIGN_CENTER, linefeed: 1));
//                                 list.add(LineText(type: LineText.TYPE_TEXT, content: 'this is conent left', weight: 0, align: LineText.ALIGN_LEFT, linefeed: 1));
//                                 list.add(LineText(type: LineText.TYPE_TEXT, content: 'this is conent right', align: LineText.ALIGN_RIGHT, linefeed: 1));
//                                 list.add(LineText(linefeed: 1));
//
//                                 // ByteData data = await rootBundle.load("assets/images/bluetooth_print.png");
//                                 // List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//                                 // String base64Image = base64Encode(imageBytes);
//                                 // list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));
//
//                                 await bluetoothPrint.printReceipt(config, list);
//                               }
//                             : null,
//                       ),
//                       OutlinedButton(
//                         child: Text('print label(tsc)'),
//                         onPressed: _connected
//                             ? () async {
//                                 Map<String, dynamic> config = Map();
//                                 config['width'] = 40; // 标签宽度，单位mm
//                                 config['height'] = 70; // 标签高度，单位mm
//                                 config['gap'] = 2; // 标签间隔，单位mm
//
//                                 // x、y坐标位置，单位dpi，1mm=8dpi
//                                 List<LineText> list = [];
//                                 list.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 10, content: 'A Title'));
//                                 list.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 40, content: 'this is content'));
//                                 list.add(LineText(type: LineText.TYPE_QRCODE, x: 10, y: 70, content: 'qrcode i\n'));
//                                 list.add(LineText(type: LineText.TYPE_BARCODE, x: 10, y: 190, content: 'qrcode i\n'));
//
//                                 List<LineText> list1 = [];
//                                 ByteData data = await rootBundle.load("assets/images/guide3.png");
//                                 List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//                                 String base64Image = base64Encode(imageBytes);
//                                 list1.add(LineText(
//                                   type: LineText.TYPE_IMAGE,
//                                   x: 10,
//                                   y: 10,
//                                   content: base64Image,
//                                 ));
//
//                                 await bluetoothPrint.printLabel(config, list);
//                                 await bluetoothPrint.printLabel(config, list1);
//                               }
//                             : null,
//                       ),
//                       OutlinedButton(
//                         child: Text('print selftest'),
//                         onPressed: _connected
//                             ? () async {
//                                 await bluetoothPrint.printTest();
//                               }
//                             : null,
//                       ),
//                       OutlinedButton(
//                         child: Text('开发系统蓝牙'),
//                         onPressed: () => FlutterBlue().openXiTongApi(),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: StreamBuilder<bool>(
//           stream: bluetoothPrint.isScanning,
//           initialData: false,
//           builder: (c, snapshot) {
//             if (snapshot.data ?? false) {
//               return FloatingActionButton(
//                 child: Icon(Icons.stop),
//                 onPressed: () => bluetoothPrint.stopScan(),
//                 backgroundColor: Colors.red,
//               );
//             } else {
//               return FloatingActionButton(child: Icon(Icons.search), onPressed: () => bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
