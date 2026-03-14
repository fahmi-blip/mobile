import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/widgets/common_widgets.dart';
import 'package:flutter_application_1/features/mahasiswa_aktif/presentation/providers/mahasiswa_aktif_provider.dart';
import 'package:flutter_application_1/features/mahasiswa_aktif/presentation/widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaAktifState = ref.watch(mahasiswaAktifNotifierProvider);
    final selectedClient = ref.watch(mahasiswaAktifApiClientProvider);

    String getClientLabel(MahasiswaAktifApiClient client) {
      switch (client) {
        case MahasiswaAktifApiClient.http:
          return 'HTTP';
        case MahasiswaAktifApiClient.dio:
          return 'DIO';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title:  Text('Mahasiswa Aktif (${getClientLabel(selectedClient)})'),
        elevation: 0,
        actions: [
          PopupMenuButton<MahasiswaAktifApiClient>(
            tooltip: 'Pilih API Client',
            icon: const Icon(Icons.sync_alt_rounded),
            onSelected: (client) {
              ref.read(mahasiswaAktifNotifierProvider.notifier).setApiClient(client);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: MahasiswaAktifApiClient.http,
                child: Text('Gunakan HTTP'),
              ),
              const PopupMenuItem(
                value: MahasiswaAktifApiClient.dio,
                child: Text('Gunakan DIO'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: mahasiswaAktifState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data mahasiswa aktif: ${error.toString()}',
          onRetry: () {
            ref.read(mahasiswaAktifNotifierProvider.notifier).refresh();
          },
        ),
        data: (mahasiswaAktifList) {
          return MahasiswaAktifListView(
            mahasiswaAktifList: mahasiswaAktifList,
            onRefresh: () async =>
                ref.invalidate(mahasiswaAktifNotifierProvider),
          );
        },
      ),
    );
  }
}
