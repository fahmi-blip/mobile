import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/widgets/common_widgets.dart';
import 'package:flutter_application_1/features/profile/presentation/providers/profile_provider.dart';
import 'package:flutter_application_1/features/profile/presentation/widgets/profile_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(profileNotifierProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: profileState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat profile: ${error.toString()}',
          onRetry: () {
            ref.read(profileNotifierProvider.notifier).refresh();
          },
        ),
        data: (profile) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(profileNotifierProvider),
            child: ListView(children: [ModernProfileCard(profile: profile)]),
          );
        },
      ),
    );
  }
}
