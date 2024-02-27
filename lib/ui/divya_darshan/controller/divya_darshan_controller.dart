import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../utils/constant.dart';
import '../../../utils/network_connectivity.dart';

class DivyaDarshanController extends GetxController{
  WebViewController controller = WebViewController();
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  bool isOffline = false;
  //
  // @override
  // void onInit() {
  //   networkConnectivity.initialise();
  //   networkConnectivity.myStream.listen((source) {
  //     source = source;
  //     // 1.
  //     switch (source.keys.toList()[0]) {
  //       case ConnectivityResult.mobile:
  //         string = source.values.toList()[0] ? 'Online' : 'Offline';
  //         break;
  //       case ConnectivityResult.wifi:
  //         string = source.values.toList()[0] ? 'Online' : 'Offline';
  //         break;
  //       case ConnectivityResult.none:
  //       default:
  //         string = 'Offline';
  //     }
  //     // 2.
  //     update();
  //     // 3.
  //   });
  //
  //   controller = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..loadRequest(
  //       Uri.parse("https://www.abjibapanichhatedi.org/life-story/"),
  //     );
  //
  //   super.onInit();
  // }


  @override
  void onInit() {
    checkConnection(false);
    super.onInit();
  }

  checkConnection(bool bool) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      isOffline = true;
      update();
    } else {
      if(bool) {
        isOffline = false;
        Constant.darshanController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse("https://www.abjibapanichhatedi.org/life-story/"),
          );
      }
    }
  }
}