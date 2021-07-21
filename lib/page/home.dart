import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/common/index.dart';
import 'package:flutter_huanhu/conpontent/ui/css.dart';
import 'package:flutter_huanhu/conpontent/ui/html/XButtom.dart';
import 'package:flutter_huanhu/conpontent/ui/my_scroll_view.dart';
import 'package:flutter_huanhu/utils/local_storage.dart';
import 'package:flutter_huanhu/utils/screem.dart';
import 'package:flutter_huanhu/conpontent/ui/index.dart';

import '../routes_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return XCustomScrollView(
      backgroundColor: Colors.white,
      loading: 'null',
      appbar: XCustomScrollViewAppbar(
        customAppBar: XAppBarWidget2(context),
      ),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 88.w + ScreenUtil().statusBarHeight,
          ),
        ),
        SliverToBoxAdapter(
          child: Text('11'),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Text('111222'),
          ),
        )
      ],
    );
  }
}

// ignore: non_constant_identifier_names
Widget XAppBarWidget2(context) {
  return Container(
    padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
    color: Colors.red,
    height: 88.w + ScreenUtil().statusBarHeight,
    width: 1334.w,
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
            Text('打印设置'),
            XButton(
              '退出',
              width: 100.w,
              height: 40.w,
              backgroundColor: Colors.greenAccent,
              textStyle: font(24, colorA: ThemeColor.active),
              callback: () {
                print(1);
                PersistentStorage().clear();
                Routers.pop(context);
              },
            ),
          ],
        )
      ],
    ),
  );
}
