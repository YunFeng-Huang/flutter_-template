// import 'dart:async';
// import 'dart:convert';



// import 'index.dart';

// //[type]: 支付类型
// //[api]: 支付接口
// //[params]: 支付参数
// //[payKey]: 支付字段
// //[callback]: 支付回调
// //[payApi]: 手动创建支付信息需要
// Future payment(
//     {type, api, params, payKey = 'paymentData', callback, payApi}) async {
//   _getData(data) {
//     return data[data['data'] == null ? 'datas' : 'data'];
//   }

//   _getPayInfo(value) {
//     return recursive(_getData(value), [payKey]);
//   }

//   var result;
//   if (type == 'weixin') {
//     var isInstalled = await fluwx.isWeChatInstalled;
//     if (isInstalled) {
//       var data = await api?.call(params);
//       if (data == null) return;
//       var payInfo = _getPayInfo(data);
//       //获取支付需要
//       Log.d(payInfo, payApi != null);
//       if (payInfo == null && payApi != null) {
//         var d = await payApi.call(data['data']);
//         payInfo = _getPayInfo(d);
//       }
//       result = jsonDecode(payInfo);
//       StreamSubscription<fluwx.BaseWeChatResponse> streamSubscription;
//       streamSubscription =
//           fluwx.weChatResponseEventHandler.listen((statusData) async {
//         throttle(() {
//           if (streamSubscription != null) streamSubscription.cancel();
//           if (statusData is fluwx.WeChatPaymentResponse) {
//             Log.d('statusData.errCode', statusData.errCode);
//             if (statusData.errCode == -2) {
//               print('您取消了支付');
//             } else if (statusData.errCode == -1) {
//               print('支付失败');
//             } else if (statusData.errCode == 0) {
//               print('支付成功');
//             }
//           }
//           return callback?.call(_getData(data), statusData);
//         }, Duration(milliseconds: 5000));
//       });
//       await fluwx.payWithWeChat(
//         appId: result['appid'].toString(),
//         partnerId: result['partnerid'].toString(),
//         prepayId: result['prepayid'].toString(),
//         packageValue: result['package'].toString(),
//         nonceStr: result['noncestr'].toString(),
//         timeStamp: int.tryParse(result['timestamp']),
//         sign: result['sign'].toString(),
//       );
//     } else {
//       showToast('微信没安装');
//     }
//   } else if (type == 'alipay') {
//     var bool = await isAliPayInstalled();
//     if (bool) {
//       var data = await api?.call(params);
//       if (data == null) return;
//       var payInfo = _getPayInfo(data);
//       //获取支付需要
//       if (payInfo == null && payApi != null) {
//         var d = await payApi.call(data['data']);
//         payInfo = _getPayInfo(d);
//       }
//       result = payInfo;
//       try {
//         var payResult = await aliPay(result);
//         callback?.call(_getData(data), payResult);
//       } on Exception catch (e) {}
//     } else {
//       showToast('支付宝没安装');
//     }
//   }
//   return;
// }
