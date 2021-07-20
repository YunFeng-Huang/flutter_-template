import 'package:flutter/services.dart';

class FlutterBlue {
  // static FlutterBlue _instance = FlutterBlue();
  // static FlutterBlue get instance => _instance;

  //这里的参数名要和底层原生的申明的参数名一样
  static const MethodChannel methodChannel = MethodChannel('samples.flutter.io/bluetooth');
  // factory FlutterBlue() {
  //   // ignore: unnecessary_null_comparison
  //   if (null == _instance) {
  //     return FlutterBlue();
  //   }
  //   return _instance;
  // }
  Future<void> openBlueTooth() async {
    //打开蓝牙
    return await methodChannel.invokeMethod('openBuleTooth');
  }

  Future<void> getBlueTooth() async {
    //检测蓝牙
    return await methodChannel.invokeMethod('getBuleTooth');
  }

  Future<void> openXiTongApi() async {
    Map<String, Object> args = Map();
    args['type'] = 'Settings.ACTION_BLUETOOTH_SETTINGS';
    //打开系统
    return await methodChannel.invokeMethod('openXiTongApi');
  }
}

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
//     print('01');
//     bluetoothPrint.startScan(timeout: Duration(seconds: 4));
//     print('0001');
//     bool? isConnected = await bluetoothPrint.isConnected;
//     print(isConnected);
//     print('0');
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
//                           Icons.check,
//                           color: Colors.green,
//                         )
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
//                             onPressed: _connected
//                                 ? null
//                                 : () async {
//                               if (isNotNull(_device) && _device!.address != null) {
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
//                               await bluetoothPrint.disconnect();
//                               await bluetoothPrint.destroy();
//                               initBluetooth();
//                               print('disconnect');
//                             }
//                                 : null,
//                           ),
//                         ],
//                       ),
//                       OutlinedButton(
//                         child: Text('print receipt(esc)'),
//                         onPressed: _connected
//                             ? () async {
//                           Map<String, dynamic> config = Map();
//                           List<LineText> list = [];
//                           list.add(LineText(type: LineText.TYPE_TEXT, content: 'A Title', weight: 1, align: LineText.ALIGN_CENTER, linefeed: 1));
//                           list.add(LineText(type: LineText.TYPE_TEXT, content: 'this is conent left', weight: 0, align: LineText.ALIGN_LEFT, linefeed: 1));
//                           list.add(LineText(type: LineText.TYPE_TEXT, content: 'this is conent right', align: LineText.ALIGN_RIGHT, linefeed: 1));
//                           list.add(LineText(linefeed: 1));
//
//                           ByteData data = await rootBundle.load("assets/images/bluetooth_print.png");
//                           List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//                           String base64Image = base64Encode(imageBytes);
//                           list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));
//
//                           await bluetoothPrint.printReceipt(config, list);
//                         }
//                             : null,
//                       ),
//                       OutlinedButton(
//                         child: Text('print label(tsc)'),
//                         onPressed: _connected
//                             ? () async {
//                           Map<String, dynamic> config = Map();
//                           config['width'] = 40; // 标签宽度，单位mm
//                           config['height'] = 70; // 标签高度，单位mm
//                           config['gap'] = 2; // 标签间隔，单位mm
//
//                           // x、y坐标位置，单位dpi，1mm=8dpi
//                           List<LineText> list = [];
//                           list.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 10, content: 'A Title'));
//                           list.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 40, content: 'this is content'));
//                           list.add(LineText(type: LineText.TYPE_QRCODE, x: 10, y: 70, content: 'qrcode i\n'));
//                           list.add(LineText(type: LineText.TYPE_BARCODE, x: 10, y: 190, content: 'qrcode i\n'));
//
//                           List<LineText> list1 = [];
//                           ByteData data = await rootBundle.load("assets/images/guide3.png");
//                           List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//                           String base64Image = base64Encode(imageBytes);
//                           list1.add(LineText(
//                             type: LineText.TYPE_IMAGE,
//                             x: 10,
//                             y: 10,
//                             content: base64Image,
//                           ));
//
//                           await bluetoothPrint.printLabel(config, list);
//                           await bluetoothPrint.printLabel(config, list1);
//                         }
//                             : null,
//                       ),
//                       OutlinedButton(
//                         child: Text('print selftest'),
//                         onPressed: _connected
//                             ? () async {
//                           await bluetoothPrint.printTest();
//                         }
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
