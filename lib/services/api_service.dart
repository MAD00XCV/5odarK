// lib/core/services/api_service.dart
import 'package:dio/dio.dart' show Dio, Response, Options;
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';


class ApiService<T> {
  final String baseUrl;
  final Dio dio;

  ApiService({required this.baseUrl}) : dio = Dio();

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<Response> getAll({int? page, String? search}) async {
    final headers = await _getHeaders();
    String url = baseUrl;
    if (page != null) url += "?page=$page";
    if (search != null && search.isNotEmpty) url += "&search=$search";
    return await dio.get(url, options: Options(headers: headers));
  }

  Future<Response> getById(dynamic id) async {
    final headers = await _getHeaders();
    return await dio.get('$baseUrl/$id', options: Options(headers: headers));
  }

  Future<Response> post(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    return await dio.post(baseUrl, data: data, options: Options(headers: headers));
  }

  Future<Response> put(dynamic id, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    return await dio.put('$baseUrl/$id', data: data, options: Options(headers: headers));
  }

  Future<Response> delete(dynamic id) async {
    final headers = await _getHeaders();
    return await dio.delete('$baseUrl/$id', options: Options(headers: headers));
  }

  Future<Response> edit(dynamic id) async {
    final headers = await _getHeaders();
    return await dio.get('$baseUrl/edit/$id', options: Options(headers: headers));
  }
}
