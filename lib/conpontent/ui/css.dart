import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/common/index.dart';
import 'package:flutter_huanhu/conpontent/ui/color_utils.dart';
import 'package:flutter_huanhu/conpontent/ui/index.dart';

class ThemeColor {
  static get disable => Color(0xFFC4C4C4);
  static get active => Color(0xFFF39038);
  static get black => Color(0x010101);
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

// ignore: non_constant_identifier_names
Widget XP(child) {
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

// ignore: non_constant_identifier_names
Widget XImg({image, fit, width, height, double? borderRadius, Color? c}) {
  _network() {
    return CachedNetworkImage(
      imageUrl: image,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  return ClipRRect(
    child: image == null || image == "null" || image.length == 0
        ? Container(width: width, height: height)
        : image.contains('http')
            ? _network()
            : Image.asset(
                image,
                fit: fit ?? BoxFit.contain,
                width: width,
                height: height,
                color: c,
              ),
    borderRadius: BorderRadius.circular(borderRadius ?? 0),
  );
}

// ignore: non_constant_identifier_names
Widget XInput({label, hintText, keyboardType, controller, onSaved, validator, textAlign = TextAlign.start, border, maxHeight, maxWidth, contentPadding, change, required = false, enabled = true}) {
  return Container(
    child: TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      textAlign: textAlign,
      enabled: enabled,
      style: font(28, color: '#3E3E3E'),
      onChanged: change,
      decoration: label != null
          ? InputDecoration(
              icon: Container(
                width: 120.w,
                child: Text(label),
              ),
              contentPadding: contentPadding ?? EdgeInsets.only(left: 0, top: 4.0, bottom: 4.0),
              hintText: hintText,
            )
          : InputDecoration(
              contentPadding: contentPadding ?? EdgeInsets.only(left: 0, top: 4.0, bottom: 4.0),
              hintText: hintText,
              border: border,
            ),
      onSaved: onSaved,
      validator: (value) {
        var str = formCheck(validator, value, required);
        return str;
      },
    ),
// decoration: BoxDecoration(
//     border: Border(bottom: BorderSide(color: HexToColor('e5e5e5')))),
  );
}

// ignore: non_constant_identifier_names
Widget XFormItem({title, trailing, defaultValue, change, validator, required, enabled}) {
  TextEditingController nameController = TextEditingController();
  nameController.text = defaultValue;
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05)))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: font(28, color: '#3E3E3E'),
        ),
        Container(
          height: 88.w,
          child: XInput(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.end,
            controller: nameController,
            hintText: trailing,
            validator: validator,
            enabled: enabled,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            change: change,
            required: required,
          ),
          width: 300.w,
        )
      ],
    ),
  );
}

// ignore:non_constant_identifier_names
Container XDivision({width, height}) {
  return Container(
    width: width,
    height: height,
    color: HexToColor(ThemeColor.line),
    margin: EdgeInsets.symmetric(vertical: 10.w),
  );
}
