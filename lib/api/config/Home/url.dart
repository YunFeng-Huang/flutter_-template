import '../../../config.dart';

class URl {
  static const String queryV2 = Config.DestinationAppletService + '/api/destination/applet/skinV2/query_v2';
  static const String scenicSpotList = Config.DestinationAppletService + '/api/destination/applet/scenic_spot/list';

  static const String scenicSpotGet = Config.DestinationAppletService + '/api/destination/applet/scenic_spot/get';
  static const String appConfigGet = Config.NoticeService + '/openapi/unauth/common/appconfig/get';

  static const String queryTitle = Config.DestinationAppletService + '/api/destination/applet/skin/query_title';
  static const String getFunctionApp = Config.SkinService + '/openapi/unauth/common/skin/app/get-function-app';
  static const String queryAllNotice = Config.DestinationAppletService + '/api/destination/applet/skin/query_all_notice';

  static const String tourAround = Config.DestinationAppletService + '/api/platform/common/tour_around';
  static const String bulletinList = Config.NoticeService + '/openapi/unauth/common/bulletin/list';
  static const String userMemberCheckAndGet = Config.DestinationAppletService + '/api/destination/applet/user_member/check_and_get';
  static const String collection = Config.DestinationAppletService + '/api/unauth/common/destination/common/member/collection/collection';
  static const String collectionStatus = Config.DestinationAppletService + '/api/unauth/common/destination/common/member/collection/status';
  static const String classifyModule = Config.DestinationAppletService + '/api/platform/common/classify-module';
  static const String areaList = Config.DestinationAppletService + '/api/platform/common/area_list';
  static const String queryBournIndex = Config.DestinationAppletService + '/api/platform/common/query_bourn_Index';

  static const String uploadFile = Config.DestinationAppletService + '/api/destination/applet/common/upload-file';
  static const String uploadBigFile = Config.DestinationAppletService + '/api/destination/applet/common/upload-file-patch';
  static const String getMapMark = Config.DestinationAppletService + '/api/destination/applet/map/get_map_mark';
  static const String summaryResult = Config.DestinationAppletService + '/openapi/auth/app/destination/ticket/rate/summary_result';
  static const String indexSearch = Config.DestinationAppletService + '/api/destination/index/search';
  static const String buriedPoint = Config.DestinationAppletService + '/api/unauth/app/destination/buried-point';
  static const String playRecommend = Config.DestinationAppletService + '/api/platform/common/play_recommend';
  static const String listRecommendBiz = Config.DestinationAppletService + '/api/platform/common/list-recommend-biz';
  static const String publicConfig = Config.DestinationAppletService + '/api/destination/applet/base/config/get/publicConfig';
  static const String shareInfo = Config.DestinationAppletService + '/openapi/auth/app/goods/share/info/get'; //获取商品分享码信息
  static const String getAppletVersion = Config.DestinationAppletService + '/api/unauth/app/get_applet_version'; //版本更新

  static const String dingTalk = 'https://oapi.dingtalk.com/robot/send?access_token=812228320f50513b96672c17879b3d00a0596272c4219b61d030ca6c41bf8b83';
}
