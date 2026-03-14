import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/features/dosen/data/models/dosen_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

final dio = Dio();

class DosenRepository {
  static const _url = 'https://jsonplaceholder.typicode.com/users';

  /// Mendapatkan daftar dosen
  Future<List<DosenModel>> getDosenList() async {
    try {
      final response = await dio.get(
        _url,
        options: Options(
          headers: const {
            'Accept': 'application/json',
            'User-Agent': 'flutter-application-1',
          },
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        final List<DosenModel> dosenList = data
            .map((json) => DosenModel.fromJson(json))
            .toList();
        return dosenList;
      } else {
        throw Exception('Gagal mendapatkan data dosen: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Fallback ke http bila request Dio diblok (mis. status 403 di emulator).
      if (e.response?.statusCode == 403 || e.error is SocketException) {
        return _getDosenListWithHttp();
      }
      throw Exception('Error saat mendapatkan data dosen: $e');
    } catch (e) {
      throw Exception('Error saat mendapatkan data dosen: $e');
    }
  }

  Future<List<DosenModel>> _getDosenListWithHttp() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: const {
        'Accept': 'application/json',
        'User-Agent': 'flutter-application-1',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((json) => DosenModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    throw Exception(
      'Gagal mendapatkan data dosen (http): ${response.statusCode}',
    );
  }
}
