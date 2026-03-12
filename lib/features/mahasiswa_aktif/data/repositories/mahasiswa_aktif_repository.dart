import 'package:flutter_application_1/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaAktifModel(
        nama: 'Budi Santoso',
        nim: '2311001',
        semester: '6',
        kelas: 'TI-6A',
      ),
      MahasiswaAktifModel(
        nama: 'Siti Rahma',
        nim: '2311002',
        semester: '6',
        kelas: 'TI-6A',
      ),
      MahasiswaAktifModel(
        nama: 'Andi Wijaya',
        nim: '2211045',
        semester: '8',
        kelas: 'TI-8B',
      ),
    ];
  }
}
