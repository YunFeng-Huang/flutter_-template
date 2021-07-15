import 'dart:core';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/conpontent/ui/color_utils.dart';
import 'package:flutter_huanhu/conpontent/ui/index.dart';

TextStyle font(double value, {bool bold = false, color = "#666666", colorA, height, lineThrough = false, letterSpacing = false}) => TextStyle(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontSize: value.w,
      color: colorA ?? (color != null ? HexToColor(color) : null),
      decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      letterSpacing: letterSpacing ? -1 : 0,
      height: height,
    );

Widget p(child) {
  return RichText(
    text: TextSpan(
      children: child
          .map<InlineSpan>(
            (e) => TextSpan(text: e['title'].toString(), style: e['style'], recognizer: new TapGestureRecognizer()..onTap = e.containsKey('onTap') ? e['onTap'] : null),
          )
          .toList(),
    ),
  );
}

Container division({width, height}) {
  return Container(
    width: width,
    height: height,
    color: HexToColor(ThemeColor.line),
    margin: EdgeInsets.symmetric(vertical: 10.w),
  );
}

class ThemeColor {
  static get disable => '#C4C4C4';
  static get active => '#F39038';
  static get activeA => Color.fromRGBO(255, 156, 0, 1);
  static get red => '#FC4F32';
  static get white => '#FFFFFF';
  static get background => '#EEEFF3';
  static get backgroundTwo => '#FCFBFD';
  static get line => '#EEEFF3';
}
