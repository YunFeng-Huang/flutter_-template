// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/common/index.dart';
import '../index.dart';
import '../css.dart';
import '../my_toast.dart';

// ignore: must_be_immutable
class XInput extends StatelessWidget {
  String? _label;
  double? _labelWidth;
  TextStyle? _labelStyle;
  String? _hintText;
  TextStyle? _hintStyle;
  TextInputType? _keyboardType;
  TextEditingController? _controller;
  TextAlign? _textAlign;
  bool? _enabled;
  EdgeInsetsGeometry? _contentPadding;
  InputBorder? _border;
  ValueChanged<String>? _onChanged;
  FormFieldSetter<String>? _onSaved;
  String? _validator;
  bool? _required;
  XInput({
    label,
    labelWidth,
    labelStyle,
    hintText,
    hintStyle,
    keyboardType,
    controller,
    // onSaved,
    validator,
    textAlign,
    border,
    onChanged,
    contentPadding,
    required,
    enabled,
  }) {
    _label = label;
    _labelWidth = labelWidth ?? 120.w;
    _labelStyle = labelStyle ?? font(12);
    _hintText = hintText;
    _hintStyle = hintStyle ?? font(12);
    _keyboardType = keyboardType;
    _controller = controller;
    _onChanged = onChanged;
// _onSaved = onSaved;
    _validator = validator;
    _textAlign = textAlign;
    _border = border;
    _contentPadding = contentPadding;
    _required = required ?? false;
    _enabled = enabled;
  }
  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode = new FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        var str = formCheck(_validator, _controller?.text.toString(), _required);
        if (isNotNull(str)) {
          showToast(str);
        }
      }
    });
    return Container(
      child: TextFormField(
        focusNode: _focusNode,
        keyboardType: _keyboardType,
        controller: _controller,
        textAlign: _textAlign ?? TextAlign.start,
        enabled: _enabled ?? true,
        style: font(12, color: '#3E3E3E'),
        onChanged: _onChanged,
        decoration: _label != null
            ? InputDecoration(
                icon: Container(
                  width: _labelWidth,
                  child: Text(
                    _label!,
                    style: _labelStyle,
                  ),
                ),
                contentPadding: _contentPadding ?? EdgeInsets.only(left: 0, top: 4.w, bottom: 4.w),
                hintText: _hintText,
                hintStyle: _hintStyle,
              )
            : InputDecoration(
                contentPadding: _contentPadding ?? EdgeInsets.only(left: 0, top: 4.w, bottom: 4.w),
                hintText: _hintText,
                hintStyle: _hintStyle,
                border: _border,
              ),
        // onSaved: _onSaved,
        // validator: (value) {
        //   print(value);
        //   print('validator');
        //   var str = formCheck(_validator, value, _required);
        //   return str;
        // },
      ),
    );
  }
}

// ignore: must_be_immutable
class XFormItem extends StatelessWidget implements XInput {
  String text;
  XFormItem(
    this.text,
    label,
    labelWidth,
    labelStyle,
    hintText,
    keyboardType,
    controller,
    onSaved,
    validator,
    textAlign,
    border,
    contentPadding,
    required,
    enabled,
  ) {
    _label = label;
    _labelWidth = labelWidth;
    _labelStyle = labelStyle;
    _hintText = hintText;
    _keyboardType = keyboardType;
    _controller = controller;
    _onSaved = onSaved;
    _validator = validator;
    _textAlign = textAlign;
    _border = border;
    _contentPadding = contentPadding;
    _required = required ?? false;
    _enabled = enabled;
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    nameController.text = text;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'title',
            style: font(28, color: '#3E3E3E'),
          ),
          Container(
            height: 88.w,
            child: XInput(
              label: _label,
              labelWidth: _labelWidth,
              labelStyle: _labelStyle,
              hintText: _hintText,
              keyboardType: _keyboardType,
              controller: _controller,
              // onSaved: _onSaved,
              // validator: _validator,
              textAlign: _textAlign,
              border: _border,
              contentPadding: _contentPadding,
              // required: _required,
              enabled: _enabled,
            ),
            width: 300.w,
          )
        ],
      ),
    );
  }

  @override
  InputBorder? _border;

  @override
  EdgeInsetsGeometry? _contentPadding;

  @override
  TextEditingController? _controller;

  @override
  bool? _enabled;

  @override
  String? _hintText;

  @override
  TextInputType? _keyboardType;

  @override
  String? _label;

  @override
  double? _labelWidth;

  @override
  ValueChanged<String>? _onChanged;

  @override
  FormFieldSetter<String>? _onSaved;

  @override
  bool? _required;

  @override
  TextAlign? _textAlign;

  @override
  String? _validator;

  @override
  TextStyle? _labelStyle;

  @override
  TextStyle? _hintStyle;
}
