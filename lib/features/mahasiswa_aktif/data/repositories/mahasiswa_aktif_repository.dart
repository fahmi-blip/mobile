import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_1/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class MahasiswaAktifRepository {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final Dio _dio;

  MahasiswaAktifRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList({
    bool useDio = false,
  }) {
    if (useDio) {
      return getMahasiswaAktifListWithDio();
    }
    return getMahasiswaAktifListWithHttp();
  }

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifListWithHttp() async {
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
              (json) =>
                  MahasiswaAktifModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }

      if (response.statusCode == 403) {
        return _fallbackMahasiswaAktif();
      }

      throw Exception(
        'Gagal mendapatkan data mahasiswa aktif (http): ${response.statusCode}',
      );
    } on SocketException {
      return _fallbackMahasiswaAktif();
    }
  }

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifListWithDio() async {
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
              (json) =>
                  MahasiswaAktifModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }

      throw Exception(
        'Gagal mendapatkan data mahasiswa aktif (dio): ${response.statusCode}',
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 403 || e.error is SocketException) {
        try {
          return await getMahasiswaAktifListWithHttp();
        } catch (_) {
          return _fallbackMahasiswaAktif();
        }
      }
      rethrow;
    }
  }

  List<MahasiswaAktifModel> _fallbackMahasiswaAktif() {
    return [
      MahasiswaAktifModel(
        nama: 'Fallback Aktif 1',
        nim: '101',
        semester: '5',
        kelas: 'TI-5A',
      ),
      MahasiswaAktifModel(
        nama: 'Fallback Aktif 2',
        nim: '102',
        semester: '3',
        kelas: 'TI-3B',
      ),
      MahasiswaAktifModel(
        nama: 'Fallback Aktif 3',
        nim: '103',
        semester: '7',
        kelas: 'TI-7A',
      ),
    ];
  }
}
