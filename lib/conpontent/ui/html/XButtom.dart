import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/common/index.dart';

import '../css.dart';
import '../index.dart';

// ignore: must_be_immutable
class XButton extends StatefulWidget {
  TextStyle? textStyle;
  String? text;
  // TextStyle textStyle;
  double? width;
  double? height;
  double? borderSize;
  Color? borderColor;
  Color? backgroundColor;
  double? shape;
  Map? params;
  Function? api;
  Function? callback;
  XButton(this.text, {this.textStyle, this.width, this.height, this.borderSize, this.borderColor, this.shape, this.params, this.api, this.callback, this.backgroundColor});
  @override
  _XButtonState createState() => _XButtonState();
}

class _XButtonState extends State<XButton> {
  TextStyle? get textStyle => widget.textStyle;
  String? get text => widget.text;
  double? get shape => widget.shape;
  double? get width => widget.width;
  double? get height => widget.height;
  double? get borderSize => widget.borderSize;
  Color? get borderColor => widget.borderColor;
  Function? get api => widget.api;
  Function? get callback => widget.callback;
  Color? get backgroundColor => widget.backgroundColor;
  Map? get params => widget.params;
  bool _disabled = false;
  void onPressed() async {
    if (api != null) {
      setState(() {
        _disabled = true;
      });
      var data = await api?.call(params);
      print(data);
      await callback?.call(data);
      setState(() {
        _disabled = false;
      });
    } else {
      callback?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _disabled ? null : onPressed,
      child: Text(
        text ?? '',
        style: textStyle ?? TextStyle(fontSize: 24.w),
      ),
      style: ButtonStyle(
        //定义文本的样式 这里设置的颜色是不起作用的
        // textStyle: MaterialStateProperty.all(TextStyle(fontSize: 12.w)),
        //设置按钮上字体与图标的颜色
        //foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
        //更优美的方式来设置
        // foregroundColor: MaterialStateProperty.resolveWith(
        //   (states) {
        //     if (states.contains(MaterialState.focused) && !states.contains(MaterialState.pressed)) {
        //       //获取焦点时的颜色
        //       return Colors.blue;
        //     } else if (states.contains(MaterialState.pressed)) {
        //       //按下时的颜色
        //       return Colors.deepPurple;
        //     }
        //     //默认状态使用灰色
        //     return Colors.grey;
        //   },
        // ),
        //背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //设置按下时的背景颜色
          if (isNotNull(backgroundColor) && states.contains(MaterialState.pressed)) {
            return backgroundColor!.withOpacity(0.8);
          }
          //默认不使用背景颜色
          return backgroundColor;
        }),
        //设置水波纹颜色
        // overlayColor: MaterialStateProperty.all(Colors.yellow),
        //设置阴影  不适用于这里的TextButton
        elevation: MaterialStateProperty.all(0),
        //设置按钮内边距
        // padding: MaterialStateProperty.all(EdgeInsets.all(4)),
        //设置按钮的大小
        minimumSize: width == null || height == null ? null : MaterialStateProperty.all(Size(width!, height!)),

        //设置边框
        side: borderSize == null ? null : MaterialStateProperty.all(BorderSide(color: borderColor ?? ThemeColor.border, width: borderSize!)),
        //外边框装饰 会覆盖 side 配置的样式
        shape: shape == null
            ? null
            : MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(shape!)),
                ),
              ),
      ),
    );
  }
}

// Widget button(title, onTap, {minWidth, width, height, color, fontStyle, disable = false, disableText, borderRadius}) {
//   return SizedBox(
//     width: width,
//     height: height,
//     child: TextButton(
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       color: color ?? HexToColor(ThemeColor.active),
//       // highlightColor: Colors.blue[700],
//       colorBrightness: Brightness.dark,
//       splashColor: Colors.grey,
//       disabledColor: HexToColor(ThemeColor.disable),
//       child: Text(disable ? disableText ?? title : title, style: fontStyle),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 20.0)),
//       onPressed: disable ? null : onTap,
//     ),
//   );
// }
