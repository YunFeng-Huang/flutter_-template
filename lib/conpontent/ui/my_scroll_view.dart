import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/common/index.dart';
import 'package:flutter_huanhu/conpontent/ui/my_loading.dart';
import 'package:flutter_huanhu/utils/screem.dart';
import './index.dart';
import 'color_utils.dart';

// ignore: must_be_immutable
class XCustomScrollView extends StatefulWidget {
  XCustomScrollViewAppbar appbar;
  Color backgroundColor;
  dynamic loading;
  List<Widget> slivers;
  Widget? bottomAppBar;
  XCustomScrollView({Key? key, this.loading, required this.slivers, required this.appbar, this.backgroundColor = Colors.transparent, this.bottomAppBar}) {
    if (bottomAppBar != null) {
      slivers.add(
        SliverToBoxAdapter(
          child: SizedBox(
            height: 110.w,
          ),
        ),
      );
    }
  }

  @override
  _XCustomScrollViewState createState() => _XCustomScrollViewState();
}

class _XCustomScrollViewState extends State<XCustomScrollView> {
  dynamic get data => widget.loading;
  XCustomScrollViewAppbar get appbar => widget.appbar;
  Color get backgroundColor => widget.backgroundColor;
  List<Widget> get slivers => widget.slivers;
  Widget? get bottomAppBar => widget.bottomAppBar;
  ScrollController controller = ScrollController();
  double opacity = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(() {
      setState(() {
        opacity = controller.offset >= 100 ? 1.00 : controller.offset / 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) return Loading();
    print(opacity);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            physics: ClampingScrollPhysics(),
            controller: controller,
            slivers: slivers,
          ),
          XAppBarWidget(
            context,
            title: appbar.title,
            color: Colors.white.withOpacity(1 - opacity),
          ).background(
            color: Colors.white.withOpacity(opacity),
          ),
          XAppBarWidget(
            context,
            title: appbar.title,
            color: Colors.black.withOpacity(opacity),
          ),
          if (bottomAppBar != null)
            Container(
              height: 98.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05), //底色,阴影颜色
                    blurRadius: 1, // 阴影模糊层度
                    spreadRadius: 1, //阴影模糊大小
                  )
                ],
              ),
              child: bottomAppBar,
            ).bottomCenter
        ],
      ),
    );
  }
}

class XCustomScrollViewAppbar {
  String title;
  XCustomScrollViewAppbar({required this.title});
}

// ignore: non_constant_identifier_names
Widget XAppBarWidget(
  context, {
  String? title,
  TextStyle? textStyle,
  Color? backgroundColor,
  Color? color,
  List<Widget>? actions,
}) {
  return Container(
    padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
    color: backgroundColor ?? Colors.transparent,
    height: 88.w + ScreenUtil().statusBarHeight,
    width: 750.w,
    child: Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Routers.pop();
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            color: color ?? HexToColor('#010101'),
          ).background(width: 88.w, height: 88.w),
        ).centerLeft.margin(left: 24.w),
        Text(
          title ?? '',
          style: TextStyle(
            fontSize: 32.w,
            color: color ?? HexToColor('#010101'),
            fontWeight: FontWeight.bold,
          ),
          // font(32, color: color ?? '#010101', bold: true),
        ).center,
        if (isNotNull(actions?.length))
          Row(
            children: List.generate(
              actions!.length,
              (index) => Container(
                child: actions[index],
                width: 88.w,
              ),
            ),
          ).background(width: 88.w * actions.length).centerRight.margin(right: 24.w),
      ],
    ),
  );
}
