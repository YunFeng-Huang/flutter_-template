import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../my_alert.dart';

class XAlert {
  BuildContext context;
  XAlert(this.context);

  /// 底部弹出提示框
  showBottomAlert({list, callback, title}) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return ShowCustomAlterWidget(callback, list, title);
      },
    );
  }

  /// 中间弹出提示框
  showCenterTipsAlter({required String title, required String info, callback}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowTipsAlterWidget(callback, title, info);
      },
    );
  }

  /// 中间弹出输入框
  showCenterInputAlert({callback, required String title, String? placeholder}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowInputAlertWidget(callback, title, placeholder);
      },
    );
  }
}
