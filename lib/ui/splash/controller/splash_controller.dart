import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:satsang/routes/app_routes.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/debugs.dart';
import '../../../../utils/network_connectivity.dart';
import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../utils/offline_popup.dart';


class SplashController extends GetxController {
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  bool isLoadData = true;
  ResumeData repo = ResumeData();



/*  Future<void> initializeNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await Constant.flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (notificationResponse.payload != null) {
          debugPrint('notification payload: $payload');
        }
        await Utils.sendData(payload.toString());
      },
    );
  }*/


  @override
  void onInit() {
    super.onInit();
    networkConnectivity.initialise();
    networkConnectivity.myStream.listen((source) async {
      source = source;
      // 1.
      switch (source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string = source.values.toList()[0] ? 'Online' : 'Offline';
          break;
        case ConnectivityResult.wifi:
          string = source.values.toList()[0] ? 'Online' : 'Offline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
      // 2.
      update();
      // 3.
      Debug.printLog("connection status=====>>>>>>>$string");
      if (string == "Online" && isLoadData) {
        isLoadData = false;
        moveToScreen();
      } else if (string == "Offline" && Constant.isOffline) {
        isLoadData = true;
        Constant.isOffline = false;
        showOfflineDialog();
      }
    });
  }

  moveToScreen() async {
    await repo.getAudioAlbum().then((value) {
      Debug.printLog("----->>> audio album $value");
      Constant.audioAlbum = value.audioAlbums!;
    });
    await repo.getPhotoAlbum().then((value) {
      Constant.photoAlbum = value.photoAlbums!;
    });
    await repo.getNews().then((value) {
      Constant.newsList = value.news!;
    });
    await repo.getMagazine().then((value) {
      Constant.magazines = value.murtiMagazines!;
    });
    await repo.getEBooks().then((value) {
      Constant.eBooks = value.ebooks!;
    });
    await repo.getAudioAlbum().then((value) {
      Constant.audioSection = value.audioSections!;
    });
    Get.offAllNamed(AppRoutes.homeScreen);
    Debug.printLog("hello world");
  }
}
