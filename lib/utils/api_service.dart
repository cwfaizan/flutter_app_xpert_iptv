import 'package:dio/dio.dart';
import 'network_client.dart';

class ApiService {
  final NetworkClient networkClient;

  ApiService({required this.networkClient});

  Future<Response> login(
      {required String baseUrl, required Map<String, Object> paramsInMap}) async {
    return await networkClient.get(baseUrl, paramsInMap);
  }

  Future<Response> get(
      {required String baseUrl, required Map<String, Object> paramsInMap}) async {
    return await networkClient.get(baseUrl, paramsInMap);
  }
}
