import 'dart:async';
import 'package:get_storage/get_storage.dart';
/* global class for handle all the preference activity into application */

class Preference {
  // Preference key

  static const String currentBalance = "currentBalance";
  static const String changeIndicatorValue = "changeIndicatorValue";
  static const String currentLevel = "currentLevel";
  static const String perClickValue = "perClickValue";
  static const String raiseLevelAmount = "raiseLevelAmount";

  static const String totalBalance = "totalBalance";
  static const String valueOfSharePortfolio = "valueOfSharePortfolio";
  static const String totalCryptoValue = "totalCryptoValue";
  static const String totalIncomeOfRealEstate = "totalIncomeOfRealEstate";
  static const String boughtRealEstate = "boughtRealEstate";
  static const String earnedInClicker = "earnedInClicker";
  static const String earnedOnRent = "earnedOnRent";

  static const String totalIncomeOfBusiness = "totalIncomeOfBusiness";

  static const String authorization = "AUTHORIZATION";
  static const String fcmToken = "FCM_TOKEN";
  static const String userData = "USER_DATA";
  static const String userId = "USER_ID";
  static const String userEmail = "USER_EMAIL";
  static const String selectedLanguage = "LANGUAGE";
  static const String selectedCountryCode = "SELECTED_COUNTRY_CODE";
  static const String count = "COUNT";
  static const String isServiceStart = "IS_SERVICE_START";
  static const String isSoundEnable = "IS_SOUND_ENABLE";
  static const String isFirstTimeActivate = "IS_FIRST_TIME_ACTIVATE";
  static const String accessToken = "ACCESS_TOKEN";
  static const String tokenType = "TOKEN_TYPE";
  static const String expiresIn = "EXPIRES_IN";
  static const String loginCurrentTime = "LOGIN_CURRENT_TIME";
  static const String isLoggedUser = "IS_LOGIN_USER";
  static const String isGoogleLogin = "IS_GOOGLE_LOGIN";
  static const String resumeId = "RESUME_ID";
  static const String selectedLanguageIndex = "SELECTED_LANGUAGE_INDEX";
  static const String storageImagesList = "STORAGE_IMAGES_LIST";
  static const String isFirstTimeStoreData = "isFirstTimeStoreData";
  static const String loginType = "LOGIN_TYPE";
  static const String activatedCarousel = "ACTIVATED_CAROUSEL";
  static const String adImage = "AD_IMAGE";
  static const String adLogo = "AD_LOGO";
  static const String downloadedAudioList = "DOWNLOADED_Audio_LIST";
  static const String downloadedBooksList = "DOWNLOADED_Books_LIST";
  static const String downloadedMagazineList = "DOWNLOADED_Magazine_LIST";

  static const String settingPhoto = "settingPhoto";
  static const String settingBirth = "settingBirth";
  static const String settingCalculation = "settingCalculation";
  static const String settingSkill = "settingSkill";
  static const String settingTextSizeCV = "settingTextSizeCV";
  static const String settingOrdering = "settingOrdering";
  static const String settingDate = "settingDate";
  static const String resumeLanguage = "resumeLanguage";
  static const String resumeName = "resumeName";
  static const String resumeType = "resumeType";

  static const String nullResumeNumber = "nullResumeNumber";
  static const String downloadedResumeName = "downloadedResumeName";

  static const String isEdit = "isEdit";
  static const String isCreateResume = "isCreateResume";
  static const String isGetNotificationPermission = "isGetNotificationPermission";
  static const String isGetStoragePermission = "isGetStoragePermission";
  static const String isGetPhotoPermission = "isGetPhotoPermission";
  static const String isNotification = "isNotification";
  static const String isStorage = "isStorage";
  static const String isPhoto = "isPhoto";
  static const String isFirstTime = "isFirstTime";

  static const int totalAttemptCountInter = 1;
  static int totalAttemptCountNative = 1;

  static const String keyUserData = "keyUserData";

  static int currentAdCount = 1;

  static var baseUrl = "";

  // ------------------ SINGLETON -----------------------
  static final Preference _preference = Preference._internal();

  factory Preference() {
    return _preference;
  }

  Preference._internal();

  static Preference get shared => _preference;

  static GetStorage? _pref;

  /* make connection with preference only once in application */
  Future<GetStorage?> instance() async {
    if (_pref != null) return _pref;
    await GetStorage.init().then((value) {
      if (value) {
        _pref = GetStorage();
      }
    }).catchError((onError) {
      _pref = null;
    });
    return _pref;
  }

  String? getString(String key) {
    return _pref!.read(key);
  }

  Future<void> setString(String key, String value) {
    return _pref!.write(key, value);
  }

  int? getInt(String key) {
    return _pref!.read(key);
  }

  Future<void> setInt(String key, int value) {
    return _pref!.write(key, value);
  }

  bool? getBool(String key) {
    return _pref!.read(key) ?? false;
  }

  Future<void> setBool(String key, bool value) {
    return _pref!.write(key, value);
  }

  double? getUserData(String key) {
    return _pref!.read(key);
  }

  // Future<void> setUserData(String key, GuestResult value) {
  //   return _pref!.write(key, value);
  // }

  // Double get & set
  double? getDouble(String key) {
    return _pref!.read(key);
  }

  Future<void> setDouble(String key, double value) {
    return _pref!.write(key, value);
  }

  // Array get & set
  List<dynamic> getStringList(String key) {
    return _pref!.read(key);
  }

  List<bool>? getBoolList(String key) {
    return _pref!.read(key);
  }

  Future<void> setStringList(String key, List<String> value) {
    return _pref!.write(key, value);
  }

  Future<void> setBoolList(String key, List<bool> value) {
    return _pref!.write(key, value);
  }

  /* remove element from preferences */
  Future<void> remove(key, [multi = false]) async {
    GetStorage? pref = await instance();
    if (multi) {
      key.forEach((f) async {
        return await pref!.remove(f);
      });
    } else {
      return await pref!.remove(key);
    }
  }

  /* remove all elements from preferences */
  static Future<bool> clear() async {
    // return await _pref.clear();
    _pref!.getKeys().forEach((key) async {
      await _pref!.remove(key);
    });

    return Future.value(true);
  }

  static Future<bool> clearLogout() async {
    await _pref!.remove(keyUserData);
    return Future.value(true);
  }
}
