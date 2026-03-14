import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:http/http.dart' as http;

class MahasiswaRepository {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com/comments';
  final Dio _dio;

  MahasiswaRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<MahasiswaModel>> getMahasiswaList({bool useDio = false}) {
    if (useDio) {
      return getMahasiswaListWithDio();
    }
    return getMahasiswaListWithHttp();
  }

  Future<List<MahasiswaModel>> getMahasiswaListWithHttp() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: const {
          'Accept': 'application/json',
          'User-Agent': 'flutter-application-1',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map(
              (json) => MahasiswaModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }

      if (response.statusCode == 403) {
        return _fallbackMahasiswa();
      }

      throw Exception(
        'Gagal mendapatkan data mahasiswa (http): ${response.statusCode}',
      );
    } on SocketException {
      return _fallbackMahasiswa();
    }
  }

  Future<List<MahasiswaModel>> getMahasiswaListWithDio() async {
    try {
      final response = await _dio.get(
        _baseUrl,
        options: Options(
          headers: const {
            'Accept': 'application/json',
            'User-Agent': 'flutter-application-1',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map(
              (json) => MahasiswaModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }

      throw Exception(
        'Gagal mendapatkan data mahasiswa (dio): ${response.statusCode}',
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 403 || e.error is SocketException) {
        try {
          return await getMahasiswaListWithHttp();
        } catch (_) {
          return _fallbackMahasiswa();
        }
      }
      rethrow;
    }
  }

  List<MahasiswaModel> _fallbackMahasiswa() {
    return [
      MahasiswaModel(
        nama: 'Fallback Mahasiswa 1',
        nim: '1',
        email: 'fallback1@example.com',
        angkatan: '2023',
      ),
      MahasiswaModel(
        nama: 'Fallback Mahasiswa 2',
        nim: '2',
        email: 'fallback2@example.com',
        angkatan: '2022',
      ),
      MahasiswaModel(
        nama: 'Fallback Mahasiswa 3',
        nim: '3',
        email: 'fallback3@example.com',
        angkatan: '2021',
      ),
    ];
  }
}
