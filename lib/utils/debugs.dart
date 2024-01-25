import 'package:flutter/cupertino.dart';

class Debug {
  // static var isShowAd = Preference.shared.getBool(Preference.isShowAd)!;
  static var isShowAd = true;
  static var isShowBanner = true;
  static var isShowOpenAd = true;

  static var inCatAd = true;
  static var outCatAd = true;
  static var isShowRewarded = true;
  static var isShowInter = false;
  static var isShowNative = true;
  static var isBoostAd = true;
  static var isBuySellAd = true;
  static var isAdxEnable = true;
  static var totalAdInterCount = 0;

  static printLog(dynamic value) {
    debugPrint(value);
  }
  static var keyNameIsShowAd = "isShowAd";
  static var keyNameInCatAd = "inCatAd";
  static var keyNameOutCatAd = "outCatAd";
  static var keyNameIsShowBanner = "isShowBanner";
  static var keyNameIsShowRewarded = "isShowRewarded";
  static var keyNameIsShowOpenAd = "isShowOpen";
  static var keyNameIsShowInter = "isShowInter";
  static var keyNameIsNativeAd = "isShowNative";
  static var keyNameIsBoostAd = "isBoost";
  static var keyNameIsBuySellAd = "isBuySellAd";
  static var keyNameIsAdxEnable = "adxEnable";
  static var keyNameIsAdx = "ADX";

  // static var googleBanner = "ca-app-pub-3940256099942544/6300978111";
  // static var googleInterstitial = "ca-app-pub-3940256099942544/1033173712";
  // static var googleRewarded = "ca-app-pub-3940256099942544/5224354917";
  // static var googleOpenApp = "";
  // static var googleNative = "ca-app-pub-3940256099942544/2247696110";

  static var googleAdMobBanner = "";
  static var googleAdMobInterstitial = "";
  static var googleAdMobRewarded = "";
  static var googleAdMobOpenApp = "";
  static var googleAdMobNative = "";

  // static var facebookBanner = "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047";
  // static var facebookInterstitial = "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617";
  // static var facebookRewarded = "";
  // static var facebookOpenApp = "";
  // static var facebookNative = "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512";
  // static var facebookNativeSmall = "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512";
  // static var facebookNativeBanner = "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512";

  static var googleAdxBanner = "";
  static var googleAdxInterstitial = "";
  static var googleAdxRewarded = "";
  static var googleAdxOpenApp = "";
  static var googleAdxNative = "";


  static var facebookBanner = "";
  static var facebookInterstitial = "";
  static var facebookRewarded = "";
  static var facebookOpenApp = "";
  static var facebookNative = "";
  static var facebookNativeSmall = "";
  static var facebookNativeBanner = "";

  static var keyNameAdType = "adType";
  static var keyNameAdTypeGoogle = "google";
  static var keyNameAdTypeFaceBook = "facebook";
  static var keyNameGoogleBanner = "googleBanner";
  static var keyNameGoogleInterstitial = "googleInterstitial";
  static var keyNameGoogleRewarded = "googleRewarded";
  static var keyNameGoogleOpenApp = "googleOpenApp";
  static var keyNameGoogleNative = "googleNative";
  static var keyNameFacebookInter = "facebookInter";
  static var keyNameFacebookRewarded = "facebookRewarded";
  static var keyNameFacebookNative = "facebookNative";

  static var adGoogleType = "g";
  static var adFacebookType = "f";
  static var adType = adFacebookType;

  static var keyTermsCondition = "terms";
  static var termsCondition = "";

  static var keyDownloadUrl = "downloadUrl";
  static var downloadUrl = "";

  static var keyPrivacyPolicy = "privacy";
  static var privacyPolicy = "";

  static var keyShareUrl = "shareUrl";
  static var shareUrl = "";

  static var keyBaseUrl = "baseURL";

  static var keyNameTotalAdInterCount = " totalAdInterCount";

  // static var baseUrl = "";


}
