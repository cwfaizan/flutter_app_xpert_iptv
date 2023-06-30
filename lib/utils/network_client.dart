import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:xpert_iptv/utils/helper.dart';

import '../error/exceptions.dart';

class NetworkClient {
  // static const baseUrl = 'http://line.extraott-iptv.com:88';
  // static const baseUrl = 'http://xtreme-ui.org/xtreme-ui-r22f/';
  Dio _dio = Dio();

  NetworkClient() {
    Helper.findUserInfo();
    BaseOptions baseOptions = BaseOptions(
      // receiveTimeout: 20000,
      // connectTimeout: 30000,
      // baseUrl: baseUrl,
      maxRedirects: 2,
    );
    _dio = Dio(baseOptions);
    // adding logging interceptor.
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        error: true,
        request: true,
        requestHeader: true,
        responseBody: false,
        responseHeader: true,
      ),
    );
  }

  // for HTTP.GET Request.
  Future<Response> get(String url, [Map<String, Object>? params]) async {
    Response response;
    try {
      response = await _dio.get(url,
          queryParameters: params,
          options: Options(
            responseType: ResponseType.json,
          ));
    } on DioError catch (exception) {
      Logger().e(exception);
      throw RemoteException(dioError: exception);
    }
    return response;
  }
}
