import 'dart:async';
import 'dart:convert';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huanhu/common/index.dart';
import 'package:flutter_huanhu/conpontent/ui/compontent/flutter_blue.dart';
import 'package:flutter_huanhu/conpontent/ui/css.dart';
import 'package:flutter_huanhu/conpontent/ui/html/XButtom.dart';
import 'package:flutter_huanhu/conpontent/ui/my_loading.dart';
import 'package:flutter_huanhu/conpontent/ui/my_scroll_view.dart';
import 'package:flutter_huanhu/conpontent/ui/my_toast.dart';
import 'package:flutter_huanhu/utils/local_storage.dart';
import 'package:flutter_huanhu/utils/log_util.dart';
import 'package:flutter_huanhu/utils/screem.dart';
import 'package:flutter_huanhu/conpontent/ui/index.dart';

import '../routes_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _activeDevice;
  String tips = 'no device connect';
  String? address;
  @override
  void initState() {
    super.initState();
    ToastCompoent.context = context;
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((_) => initBluetooth());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("-didChangeAppLifecycleState-" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        address = await _startScan();
        print(address);
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  Future<String> _startScan() async {
    setState(() {
      _activeDevice = null;
      _connected = false;
    });
    String _address = await FlutterBlue().getBondedDevices();
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));
    return _address;
  }

  Future<void> initBluetooth() async {
    await bluetoothPrint.destroy();
    address = await _startScan();
    bluetoothPrint.state.listen((state) async {
      print('cur device status1: $state');
      switch (state) {
        case BluetoothPrint.CONNECTED:
          _connected = true;
          break;
        case BluetoothPrint.DISCONNECTED:
          _connected = false;
          break;
        default:
          break;
      }
      setState(() {});
    });
    bluetoothPrint.scanResults.listen((List<BluetoothDevice> event) {
      _activeDevice = null;
      event.any((element) {
        if (element.address == address) {
          _activeDevice = element;
        }
        return element.address == address;
      });
      if (isNotNull(_activeDevice)) {
        throttle(() async {
          bluetoothPrint.connect(_activeDevice!);
          bool? isConnected = await bluetoothPrint.isConnected;
          if (isConnected ?? false) {
            _connected = true;
            setState(() {});
          }
        }, Duration(seconds: 8));
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildXCustomScrollView(context);
  }

  Widget _buildXCustomScrollView(BuildContext context) {
    return XCustomScrollView(
      backgroundColor: Colors.white,
      loading: 'null',
      appbar: XCustomScrollViewAppbar(
        customAppBar: Container(
          padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
          color: Colors.red,
          height: 88.w + ScreenUtil().statusBarHeight,
          width: 1280.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('缆车12345-001'),
                  Text('司机：张三'),
                ],
              ),
              Row(
                children: [
                  isNotNull(_activeDevice?.name) && _activeDevice!.name!.contains('MPT')
                      ? OutlinedButton(
                          child: Text(_connected ? '${_activeDevice?.name}' : 'loading').margin(right: 20.w),
                          onPressed: _connected
                              ? null
                              : () async {
                                  showToast('正在连接。。。请确保设备已开！');
                                  initBluetooth();
                                },
                        )
                      : OutlinedButton(
                          child: Text('未连接'),
                          onPressed: () async {
                            FlutterBlue().openXiTongApi();
                          },
                        ),
                  XButton(
                    '退出',
                    width: 100.w,
                    height: 40.w,
                    // backgroundColor: Colors.greenAccent,
                    textStyle: font(24, colorA: ThemeColor.active),
                    callback: () {
                      PersistentStorage().clear();
                      Routers.pushNamed(routes.login, context: context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 88.w + ScreenUtil().statusBarHeight,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: RefreshIndicator(
              onRefresh: () => bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: Column(
                        children: <Widget>[
                          OutlinedButton(
                            child: Text('print receipt(esc)'),
                            onPressed: _connected
                                ? () async {
                                    Map<String, dynamic> config = Map();
                                    List<LineText> list = [];
                                    list.add(LineText(type: LineText.TYPE_TEXT, content: 'A Title', weight: 1, align: LineText.ALIGN_CENTER, linefeed: 1));
                                    // list.add(LineText(type: LineText.TYPE_TEXT, content: 'this is conent left', weight: 0, align: LineText.ALIGN_LEFT, linefeed: 1));
                                    // list.add(LineText(type: LineText.TYPE_TEXT, content: '撒地方撒多浪费绝对是咖啡机隆盛科技放得开洛杉矶的反馈的洛杉矶福克斯来得及发了多少 ', align: LineText.ALIGN_RIGHT, linefeed: 2));
                                    // list.add(LineText(linefeed: 1));

                                    // ByteData data = await rootBundle.load("assets/images/hot.png");
                                    // List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
                                    // String base64Image = base64Encode(imageBytes);
                                    // list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));

                                    await bluetoothPrint.printReceipt(config, list);
                                  }
                                : null,
                          ),
                          OutlinedButton(
                            child: Text('print label(tsc)'),
                            onPressed: _connected
                                ? () async {
                                    Map<String, dynamic> config = Map();
                                    config['width'] = 40; // 标签宽度，单位mm
                                    config['height'] = 70; // 标签高度，单位mm
                                    config['gap'] = 2; // 标签间隔，单位mm

                                    // x、y坐标位置，单位dpi，1mm=8dpi
                                    List<LineText> list = [];
                                    list.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 10, content: 'A Title'));
                                    list.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 40, content: 'this is content'));
                                    list.add(LineText(type: LineText.TYPE_QRCODE, x: 10, y: 70, content: 'qrcode i\n'));
                                    list.add(LineText(type: LineText.TYPE_BARCODE, x: 10, y: 190, content: 'qrcode i\n'));

                                    List<LineText> list1 = [];
                                    ByteData data = await rootBundle.load("assets/images/hot.png");
                                    List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
                                    String base64Image = base64Encode(imageBytes);
                                    list1.add(LineText(
                                      type: LineText.TYPE_IMAGE,
                                      x: 10,
                                      y: 10,
                                      content: base64Image,
                                    ));

                                    await bluetoothPrint.printLabel(config, list);
                                    await bluetoothPrint.printLabel(config, list1);
                                  }
                                : null,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

// ignore: non_constant_identifier_names
