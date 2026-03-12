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
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      angkatan: json['angkatan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama': nama, 'nim': nim, 'email': email, 'angkatan': angkatan};
  }
}
