import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:flutter_application_1/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

enum MahasiswaApiClient { http, dio }

final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

final mahasiswaApiClientProvider = StateProvider<MahasiswaApiClient>(
  (ref) => MahasiswaApiClient.http,
);

class MahasiswaNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final Ref _ref;

  MahasiswaNotifier(this._repository, this._ref)
    : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      final selectedClient = _ref.read(mahasiswaApiClientProvider);
      final data = await _repository.getMahasiswaList(
        useDio: selectedClient == MahasiswaApiClient.dio,
      );
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaList();
  }

  Future<void> setApiClient(MahasiswaApiClient apiClient) async {
    _ref.read(mahasiswaApiClientProvider.notifier).state = apiClient;
    await loadMahasiswaList();
  }
}

final mahasiswaNotifierProvider =
    StateNotifierProvider.autoDispose<
      MahasiswaNotifier,
      AsyncValue<List<MahasiswaModel>>
    >((ref) {
      final repository = ref.watch(mahasiswaRepositoryProvider);
      return MahasiswaNotifier(repository, ref);
    });
