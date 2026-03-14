import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:flutter_application_1/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart';

enum MahasiswaAktifApiClient { http, dio }

final mahasiswaAktifRepositoryProvider = Provider<MahasiswaAktifRepository>((
  ref,
) {
  return MahasiswaAktifRepository();
});

final mahasiswaAktifApiClientProvider = StateProvider<MahasiswaAktifApiClient>(
  (ref) => MahasiswaAktifApiClient.http,
);

class MahasiswaAktifNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepository _repository;
  final Ref _ref;

  MahasiswaAktifNotifier(this._repository, this._ref)
    : super(const AsyncValue.loading()) {
    loadMahasiswaAktifList();
  }

  Future<void> loadMahasiswaAktifList() async {
    state = const AsyncValue.loading();
    try {
      final selectedClient = _ref.read(mahasiswaAktifApiClientProvider);
      final data = await _repository.getMahasiswaAktifList(
        useDio: selectedClient == MahasiswaAktifApiClient.dio,
      );
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaAktifList();
  }

  Future<void> setApiClient(MahasiswaAktifApiClient apiClient) async {
    _ref.read(mahasiswaAktifApiClientProvider.notifier).state = apiClient;
    await loadMahasiswaAktifList();
  }
}

final mahasiswaAktifNotifierProvider =
    StateNotifierProvider.autoDispose<
      MahasiswaAktifNotifier,
      AsyncValue<List<MahasiswaAktifModel>>
    >((ref) {
      final repository = ref.watch(mahasiswaAktifRepositoryProvider);
      return MahasiswaAktifNotifier(repository, ref);
    });
