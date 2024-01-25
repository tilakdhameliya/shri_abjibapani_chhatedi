// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import '../utils/debugs.dart';
import '../utils/utils.dart';


class DioClient {
  var cancelToken = CancelToken();
  var dio = Dio(
    BaseOptions(
        receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60) ,
      baseUrl:Utils.getBaseUrl,
    ),

  );

  DioClient({bool isMultipart = false,bool isPassAuth = false}) {
    // var header = Preference.shared.getString(Preference.accessToken) ?? "";
    var header = "";
    if(isPassAuth) {
      // header = Utils.getUserData()!.token ?? "";
    }
    Debug.printLog("headerheader==>>> $header  ${Utils.getBaseUrl}");
    dio.interceptors.add(AppInterceptors());
    dio.options.headers = {
      'Content-Type': !isMultipart
          ? 'application/json'
          : 'multipart/form-data',
      'Accept': 'application/json',
      'requiresToken': '',
      if(isPassAuth && header != "")
      'Authorization': "Bearer $header",
    };
  }
}

/*String getBaseURL() {
  return Constant.getMainURL();
}*/

class AppInterceptors extends Interceptor {
  AppInterceptors();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Debug.printLog("On Request ==>> ");
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Debug.printLog("On DioError ==>> ${err.message}");
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Debug.printLog("On Response ==>> ");
    super.onResponse(response, handler);
  }
}
