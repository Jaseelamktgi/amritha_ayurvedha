import 'dart:developer';

import 'package:amritha_ayurvedha/core/api/api_paths.dart';
import 'package:amritha_ayurvedha/core/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiService.instance.post(ApiPaths.login, {
        "username": username,
        "password": password,
      }, asFormData: true);

      log('Login response>>>>>>>>>>>>>>> ${response.data}', name: 'Auth');

      if (response.statusCode == 200 && response.data != null) {
        final token = response.data['token'];
        log('access token >>>>>>>>>>>>>>>> $token');
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = "Token not received";
        }
      } else {
        _errorMessage = response.data['message'] ?? 'Login failed';
      }
    } on DioError catch (e) {
      print('Login DioError: ${e.message}');
    } catch (e) {
      _errorMessage = e.toString();
      print('Login Error: ${_errorMessage}');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
