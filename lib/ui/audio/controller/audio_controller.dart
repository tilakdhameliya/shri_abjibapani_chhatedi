import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/network_connectivity.dart';
import '../../../utils/utils.dart';

class AudioController extends GetxController {
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  bool isLoadData = true;
  repoData repo = repoData();
  bool isOffline = false;
  bool isLoader = false;
  bool isCall = false;

  checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      isOffline = true;
      update();
    } else {
      isOffline = false;
      getData();
    }
  }

  @override
  void onInit() {
    checkConnection();
    super.onInit();
  }

  getData() async {
    isLoader = true;
    await repo.getAudioAlbum().then((value) {
      Constant.audioSection = value.audioSections!;
      Constant.audioAlbum = value.audioAlbums!;
    });
    isLoader = false;
    update();
  }
}