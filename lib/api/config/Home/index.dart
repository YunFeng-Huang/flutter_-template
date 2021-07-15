import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/config.dart';
import 'package:flutter_huanhu/conpontent/ui/my_uploadFile.dart';
import 'package:flutter_huanhu/conpontent/ui/toast.dart';
import 'package:flutter_huanhu/utils/log_util.dart';
import 'package:image_picker/image_picker.dart';

import '../../../main.dart';
import '../../Api.dart';
import 'url.dart';

class HomeApi {
  static Future queryTitle(Map<String, dynamic> params) async {
    Options setOption = Options()..headers = {'needToken': true};
    var response = await Api.request(URl.queryTitle,
            data: params,
            queryParameters: {
              'queryParameters': 111,
            },
            setOption: setOption)
        .catchError((onError) {
      return null;
    });
    return response;
  }

  static Future uploadBigFile() async {
    await XupLoadFile.getVideo(ImageSource.gallery);
    String token = await getToken();

    var previewLink = await XupLoadFile.upload(
      type: 'video',
      url: Config.baseUrl + URl.uploadBigFile,
      token: token,
      merchantId: Config.merchantId,
    );
    print(previewLink);
    // var response = await Api.putBigFile(URl.uploadBigFile, filePath);
    // var previewLink = jsonDecode(response)['previewLink'];
    return previewLink;
  }
}
