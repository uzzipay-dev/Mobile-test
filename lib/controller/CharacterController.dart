import 'package:dio/dio.dart';
import 'package:mobile_test/env/Env.dart';
import 'package:mobile_test/models/Episode.dart';
import 'package:mobile_test/models/allCharacters.dart';

class CharacterController {
  static final Dio _dio = Dio();

  Future<AllCharacters> getAllCharacters({String? url}) async {
    try {
      late var response;
      if (url == null) {
        response = await _dio.get('${baseURL}/character');
      } else {
        response = await _dio.get(url);
      }

      return AllCharacters.fromJson(response.data);
    } on DioError {
      rethrow;
    }
  }

  Future epsode({required String epsodeUrl}) async {
    var response = await _dio.get(epsodeUrl);
    return Episode.fromJson(response.data);
  }

  Future<AllCharacters> getFilterCharacters(
      {required String type, required String value}) async {
    try {
      late var response;
      if (value.isEmpty) {
        response = await _dio.get('${baseURL}/character');
      } else {
        response = await _dio.get('${baseURL}/character/?${type}=${value}');
      }

      return AllCharacters.fromJson(response.data);
    } on DioError {
      rethrow;
    }
  }
}
