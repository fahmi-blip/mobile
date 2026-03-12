class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final String semester;
  final String kelas;

  MahasiswaAktifModel({
    required this.nama,
    required this.nim,
    required this.semester,
    required this.kelas,
  });

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaAktifModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      semester: json['semester'] ?? '',
      kelas: json['kelas'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama': nama, 'nim': nim, 'semester': semester, 'kelas': kelas};
  }
}
