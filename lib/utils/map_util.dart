// import 'dart:io';
// import 'package:amap_map_fluttify/amap_map_fluttify.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sxwl/common/datas_to/type_model.dart';
// import 'package:flutter_sxwl/common/global.dart';
// import './index.dart';
// import 'package:flutter_sxwl/utils/misc.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MapUtil {
//   static Location location;

//   /// 高德地图
//   static Future<String> gotoAMap(latitude, longitude) async {
//     Log.d(latitude, longitude);
//     LatLng target = LatLng(
//         double.parse(latitude.toString()), double.parse(longitude.toString()));
//     // var url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=applicationName&lat=${target.latitude}&lon=${target.longitude}&dev=1&style=2';
//     var url = "";
//     if (Platform.isAndroid) {
//       url =
//           'amapuri://route/plan/?sid=&dlat=${target.latitude}&dlon=${target.longitude}';
//     } else {
//       url =
//           "iosamap://path?sourceApplication=applicationName&dlat=${target.latitude}&dlon=${target.longitude}";
//     }

//     bool canLaunchUrl = await canLaunch(url);

//     if (!canLaunchUrl) {
//       return '未检测到高德地图~';
//     }

//     await launch(url);
//     return '';
//   }

//   /// 腾讯地图
//   static Future<String> gotoTencentMap(latitude, longitude) async {
//     LatLng target = LatLng(double.parse(latitude), double.parse(longitude));
//     var url =
//         'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=${target.latitude},${target.longitude}&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ';
//     bool canLaunchUrl = await canLaunch(url);

//     if (!canLaunchUrl) {
//       return '未检测到腾讯地图~';
//     }

//     await launch(url);

//     return '';
//   }

//   /// 百度地图
//   static Future<String> gotoBaiduMap(latitude, longitude) async {
//     LatLng target = LatLng(double.parse(latitude), double.parse(longitude));
//     var url =
//         'baidumap://map/direction?destination=${target.latitude},${target.longitude}&coord_type=bd09ll&mode=driving';

//     bool canLaunchUrl = await canLaunch(url);

//     if (!canLaunchUrl) {
//       return '未检测到百度地图~';
//     }

//     await launch(url);

//     return '';
//   }

//   /// 苹果地图
//   static Future<String> gotoAppleMap(latitude, longitude) async {
//     LatLng target = LatLng(double.parse(latitude), double.parse(longitude));
//     var url =
//         'http://maps.apple.com/?&daddr=${target.latitude},${target.longitude}';

//     bool canLaunchUrl = await canLaunch(url);

//     if (!canLaunchUrl) {
//       return '打开失败~';
//     }

//     await launch(url);
//     return '';
//   }

//   static Future<bool> hasAMap() async {
//     var url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi';
//     return await canLaunch(url);
//   }

//   static Future<bool> hasTencentMap() async {
//     var url = 'qqmap://map/routeplan';
//     return await canLaunch(url);
//   }

//   static Future<bool> hasBaiduMap() async {
//     var url = 'baidumap://map/direction';
//     return await canLaunch(url);
//   }

//   static Future Jump(v, latitude, longitude) async {
//     Log.d('latitude, longitude');
//     Log.d(latitude, longitude);
//     if (v == MapTypeEnum.aMap) {
//       await MapUtil.gotoAMap(latitude, longitude);
//     } else if (v == MapTypeEnum.tenCentMap) {
//       await MapUtil.gotoTencentMap(latitude, longitude);
//     } else {
//       await MapUtil.gotoBaiduMap(latitude, longitude);
//     }
//   }

//   static Future<List> hasMap() async {
//     var arr = [];
//     var hasAMap = await MapUtil.hasAMap();
//     var hasTenCentMap = await MapUtil.hasTencentMap();
//     var hasBaiDuMap = await MapUtil.hasBaiduMap();
//     if (hasAMap) arr.add(MapTypeEnum.aMap);
//     if (hasTenCentMap) arr.add(MapTypeEnum.tenCentMap);
//     if (hasBaiDuMap) arr.add(MapTypeEnum.baiDuMap);
//     return arr;
//   }

//   static getLocation() async {
//     location = await AmapLocation.instance.fetchLocation();
//     print('location---->$location');
//     return location;
//   }
// }
