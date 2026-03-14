import 'package:flutter_application_1/features/dosen/data/repositories/dosen_repository.dart';
import 'package:flutter_application_1/features/mahasiswa/data/repositories/mahasiswa_repository.dart';
import 'package:flutter_application_1/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart';
import '../models/dashboard_model.dart';

class DashboardRepository {
  final DosenRepository _dosenRepository;
  final MahasiswaRepository _mahasiswaRepository;
  final MahasiswaAktifRepository _mahasiswaAktifRepository;

  DashboardRepository({DosenRepository? dosenRepository})
    : _dosenRepository = dosenRepository ?? DosenRepository(),
      _mahasiswaRepository = MahasiswaRepository(),
      _mahasiswaAktifRepository = MahasiswaAktifRepository();
  

  Future<DashboardData> getDashboardData() async {
    // Simulasi delay untuk meniru pengambilan data dari API
    await Future.delayed(const Duration(seconds: 1));

    int totalDosen = 0;
    try {
      final dosenList = await _dosenRepository.getDosenList();
      totalDosen = dosenList.length;
    } catch (_) {
      totalDosen = 0;
    }
    int totalMahasiswa = 0;
    try {
      final MahasiswaList = await _mahasiswaRepository.getMahasiswaList();
      totalMahasiswa = MahasiswaList.length; // Contoh data statis
    } catch (_) {
      totalMahasiswa = 0;
    }

    int totalMahasiswaAktif = 0;
    try {
      final mahasiswaAktifList = await _mahasiswaAktifRepository.getMahasiswaAktifList();
      totalMahasiswaAktif = mahasiswaAktifList.length; // Contoh data statis
    } catch (_) {
      totalMahasiswaAktif = 0;
    }

    // Data dummy untuk dashboard
    return DashboardData(
      userName: 'Admin D4TI',
      lastUpdate: DateTime.now(),
      stats: [
        DashboardStats(
          title: 'Total Mahasiswa',
          value: totalMahasiswa.toString(),
          subtitle: 'Mahasiswa terdaftar',
          // percentage: 8.5,
          // isIncrease: true,
        ),
        DashboardStats(
          title: 'Mahasiswa Aktif',
          value: totalMahasiswaAktif.toString(),
          subtitle: 'Sedang Kuliah',
          // percentage: 5.2,
          // isIncrease: true,
        ),
        DashboardStats(
          title: 'Profile',
          subtitle: 'Profile Admin',
          value: '1',
          // percentage: 3.5,
          // isIncrease: true,
        ),
        DashboardStats(
          title: 'Dosen',
          value: totalDosen.toString(),
          subtitle: 'Dosen aktif',
          // percentage: 2.1,
          // isIncrease: true,
        ),
      ],
    );
  }

  Future<DashboardData> refreshDashboard() async {
    return getDashboardData();
  }

  Future<DashboardStats?> getStatByTitle(String title) async {
    final data = await getDashboardData();
    try {
      return data.stats.firstWhere((stat) => stat.title == title);
    } catch (e) {
      return null; // Jika tidak ditemukan, kembalikan null
    }
  }
}
