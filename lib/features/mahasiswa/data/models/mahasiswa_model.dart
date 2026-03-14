class MahasiswaModel {
  final String nama;
  final String nim;
  final String email;
  final String angkatan;

  MahasiswaModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.angkatan,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      nama: (json['nama'] ?? json['name'] ?? '').toString(),
      nim: (json['nim'] ?? json['id'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      angkatan: (json['angkatan'] ?? json['postId'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama': nama, 'nim': nim, 'email': email, 'angkatan': angkatan};
  }
}
