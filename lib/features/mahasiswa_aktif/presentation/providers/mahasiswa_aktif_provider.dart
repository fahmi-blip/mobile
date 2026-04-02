import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/services/local_storage_service.dart';
import 'package:flutter_application_1/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:flutter_application_1/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart';

final mahasiswaAktifRepositoryProvider = Provider<MahasiswaAktifRepository>((
  ref,
) {
  return MahasiswaAktifRepository();
});

final mahasiswaAktifLocalStorageServiceProvider = Provider<LocalStorageService>(
  (ref) {
    return LocalStorageService();
  },
);

final mahasiswaAktifSavedUsersProvider =
    FutureProvider<List<Map<String, String>>>((ref) async {
      final storage = ref.watch(mahasiswaAktifLocalStorageServiceProvider);
      return storage.getSavedUsers();
    });

final mahasiswaAktifSavedUserProvider = FutureProvider<Map<String, String?>>((
  ref,
) async {
  final storage = ref.watch(mahasiswaAktifLocalStorageServiceProvider);
  final userId = await storage.getUserId();
  final username = await storage.getUsername();
  final token = await storage.getToken();
  return {'userId': userId, 'username': username, 'token': token};
});

class MahasiswaAktifNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepository _repository;
  final LocalStorageService _storage;

  MahasiswaAktifNotifier(this._repository, this._storage)
    : super(const AsyncValue.loading()) {
    loadMahasiswaAktifList();
  }

  Future<void> loadMahasiswaAktifList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaAktifList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaAktifList();
  }

  Future<void> saveSelectedMahasiswa(MahasiswaAktifModel mahasiswa) async {
    await _storage.addUserToSavedList(
      userId: mahasiswa.nim,
      username: mahasiswa.nama,
    );
  }

  Future<void> removeSavedUser(String userId) async {
    await _storage.removeSavedUser(userId);
  }

  Future<void> clearSavedUsers() async {
    await _storage.clearSavedUsers();
  }
}

final mahasiswaAktifNotifierProvider =
    StateNotifierProvider.autoDispose<
      MahasiswaAktifNotifier,
      AsyncValue<List<MahasiswaAktifModel>>
    >((ref) {
      final repository = ref.watch(mahasiswaAktifRepositoryProvider);
      final storage = ref.watch(mahasiswaAktifLocalStorageServiceProvider);
      return MahasiswaAktifNotifier(repository, storage);
    });
