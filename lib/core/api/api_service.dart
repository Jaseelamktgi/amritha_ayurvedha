import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_paths.dart';
import 'dart:developer';

class ApiService {
  late Dio _dio;

  ApiService._internal() {
    final options = BaseOptions(
      baseUrl: ApiPaths.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {"Accept": "application/json"},
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';

          if (token.isNotEmpty) {
            options.headers['Authorization'] = "Bearer $token";
          }

          log(
            'API Request: ${options.method} ${options.uri}\nHeaders: ${options.headers}\nData: ${options.data}',
          );

          return handler.next(options);
        },
        onResponse: (response, handler) {
          log(
            'API Response: ${response.statusCode} ${response.requestOptions.uri}\nData: ${response.data}',
          );
          return handler.next(response);
        },
        onError: (error, handler) {
          log(
            'API Error: ${error.message}\nURL: ${error.requestOptions.uri}\nData: ${error.response?.data}',
          );
          return handler.next(error);
        },
      ),
    );
  }

  static final ApiService _instance = ApiService._internal();
  static ApiService get instance => _instance;

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    return await _dio.get(path, queryParameters: queryParams);
  }

  Future<Response> post(
    String path,
    Map<String, dynamic> body, {
    bool asFormData = false,
  }) async {
    final data = asFormData ? FormData.fromMap(body) : body;
    return await _dio.post(path, data: data);
  }

  Future<Response> patch(
    String path,
    Map<String, dynamic> body, {
    bool asFormData = false,
  }) async {
    final data = asFormData ? FormData.fromMap(body) : body;
    return await _dio.patch(path, data: data);
  }

  Future<Response> delete(String path, {Map<String, dynamic>? body}) async {
    return await _dio.delete(path, data: body);
  }
}
