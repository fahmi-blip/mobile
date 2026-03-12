class ProfileModel {
  final String nama;
  final String role;
  final String email;
  final String id;
  final String prodi;

  ProfileModel({
    required this.nama,
    required this.role,
    required this.email,
    required this.id,
    required this.prodi,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nama: json['nama'] ?? '',
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? '',
      prodi: json['prodi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'role': role,
      'email': email,
      'id': id,
      'prodi': prodi,
    };
  }
}
