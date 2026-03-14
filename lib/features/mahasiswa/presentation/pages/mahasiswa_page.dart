import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/widgets/common_widgets.dart';
import 'package:flutter_application_1/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:flutter_application_1/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);
    final selectedClient = ref.watch(mahasiswaApiClientProvider);

    String getClientLabel(MahasiswaApiClient client) {
      switch (client) {
        case MahasiswaApiClient.http:
          return 'HTTP';
        case MahasiswaApiClient.dio:
          return 'DIO';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa (${getClientLabel(selectedClient)})'),
        elevation: 0,
        actions: [
          PopupMenuButton<MahasiswaApiClient>(
            tooltip: 'Pilih API Client',
            icon: const Icon(Icons.sync_alt_rounded),
            onSelected: (client) {
              ref.read(mahasiswaNotifierProvider.notifier).setApiClient(client);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: MahasiswaApiClient.http,
                child: Text('Gunakan HTTP'),
              ),
              const PopupMenuItem(
                value: MahasiswaApiClient.dio,
                child: Text('Gunakan DIO'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.read(mahasiswaNotifierProvider.notifier).refresh();
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: mahasiswaState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data mahasiswa: ${error.toString()}',
          onRetry: () {
            ref.read(mahasiswaNotifierProvider.notifier).refresh();
          },
        ),
        data: (mahasiswaList) {
          return MahasiswaListView(
            mahasiswaList: mahasiswaList,
            onRefresh: () async =>
                ref.read(mahasiswaNotifierProvider.notifier).refresh(),
          );
        },
      ),
    );
  }
}
