class Config {
  //版本号
  static get version => '1.0.7';
  static final isDev = false; // true 开发坏境/ false 打包环境
  static final isProd = true; // true 上线 / false 演示环境
  //10000241 10000258
  static final merchantId = 10000241;

  static final debug = true; //是否开启打印 dev 开启
  static final onError = !bool.fromEnvironment('dart.vm.product'); //开启日志上传 prod 开启
  static final prodUrl = isProd ? 'https://superapp.juntuyun.com/' : "https://sxtourgroup.juntuyun.com/";
  //灰度s
  static get grayVersion => isDev ? 'develop-shanlv' : '';
  static get baseUrl => isDev ? 'https://dev-gateway.iuctrip.com/' : prodUrl;
  // static get clientType => isDev ? 'sl-app' : 'sl-app';
  //oss
  static const OssBaseUrl = 'https://oss.iuctrip.com/';
  //服务
  static const String DestinationAppletService = 'destination-applet-service';
  static const String MemberService = 'member-service';
  static const String MerchantService = 'merchant-service';
  static const String NoticeService = 'notice-service';
  static const String SkinService = 'skin-service';
  static const String RateService = 'rate-service';

  static String bg = 'https://oss.iuctrip.com/test/tesla/merchant/10000241/user/logo/1607942816376ooeust4p.png';
}
