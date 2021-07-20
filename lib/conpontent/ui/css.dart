import 'dart:core';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/conpontent/ui/color_utils.dart';
import 'package:flutter_huanhu/conpontent/ui/index.dart';

class ThemeColor {
  static get disable => Color(0xFFC4C4C4);
  static get active => Color(0xFFF39038);
  static get red => Color(0xFFFFC4F32);
  static get white => Color(0xFFFFFFFF);
  static get background => Color(0xFFEEEFF3);
  static get line => Color(0xFFEFF3);
}

TextStyle font(double value, {bool bold = false, color = "#666666", colorA, height, lineThrough = false, letterSpacing = false}) => TextStyle(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontSize: value.w,
      color: colorA ?? (color != null ? HexToColor(color) : null),
      decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      letterSpacing: letterSpacing ? -1 : 0,
      height: height,
    );

Widget P(child) {
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

// ignore:non_constant_identifier_names
Container Division({width, height}) {
  return Container(
    width: width,
    height: height,
    color: HexToColor(ThemeColor.line),
    margin: EdgeInsets.symmetric(vertical: 10.w),
  );
}
