import 'package:flutter_application_1/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getProfile() async {
    await Future.delayed(const Duration(seconds: 1));

    return ProfileModel(
      nama: 'Admin D4TI',
      role: 'Administrator',
      email: 'admin.d4ti@example.com',
      id: 'ADM-001',
      prodi: 'D4 Teknik Informatika',
    );
  }
}
