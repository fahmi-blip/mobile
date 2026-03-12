import 'package:flutter_application_1/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '2311001',
        email: 'budi.santoso@example.com',
        angkatan: '2023',
      ),
      MahasiswaModel(
        nama: 'Siti Rahma',
        nim: '2311002',
        email: 'siti.rahma@example.com',
        angkatan: '2023',
      ),
      MahasiswaModel(
        nama: 'Andi Wijaya',
        nim: '2211045',
        email: 'andi.wijaya@example.com',
        angkatan: '2022',
      ),
    ];
  }
}
