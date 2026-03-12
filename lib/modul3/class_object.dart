import 'dart:io';

mixin Penelitian {
  void meneliti() {
    print("Aktivitas: Melakukan penelitian.");
  }
}

mixin Pengabdian {
  void mengabdi() {
    print("Aktivitas: Melakukan pengabdian kepada masyarakat.");
  }
}

mixin Organisasi {
  void berorganisasi() {
    print("Aktivitas: Aktif dalam organisasi kampus.");
  }
}

class Mahasiswa {
  String? nama;
  int? nim;
  String? jurusan;

  void tampilkanData() {
    print("Nama: ${nama ?? 'Belum diisi'}");
    print("Nim: ${nim ?? 'Belum diisi'}");
    print("Jurusan: ${jurusan ?? 'Belum diisi'}");
  }
}

class MahasiswaAktif extends Mahasiswa {
  int? semester;

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("Semester: ${semester ?? 'Belum diisi'}");
  }
}

class MahasiswaAlumni extends Mahasiswa {
  int? tahunLulus;

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("Tahun Lulus: ${tahunLulus ?? 'Belum diisi'}");
  }
}

class Dosen extends Mahasiswa with Penelitian, Pengabdian {
  String? nidn;

  @override
  void tampilkanData() {
    print("--- Data Dosen ---");
    print("Nama: ${nama ?? 'Belum diisi'}");
    print(
      "NIDN: ${nidn ?? 'Belum diisi'}",
    ); 
    print("Bidang: ${jurusan ?? 'Belum diisi'}");
    meneliti();
    mengabdi();
  }
}

class Fakultas extends Mahasiswa with Organisasi {
  String? namaFakultas;

  @override
  void tampilkanData() {
    print("--- Informasi Fakultas ---");
    print("Fakultas: ${namaFakultas ?? 'Belum diisi'}");
    print("Dekan/Terkait: ${nama ?? 'Belum diisi'}");
    berorganisasi();
  }
}

void main() {
  print("=== Data Dosen ===");
  Dosen dosen = Dosen();
  print("Masukkan Nama Dosen:");
  dosen.nama = stdin.readLineSync();
  print("Masukkan NIDN:");
  dosen.nidn = stdin.readLineSync();
  print("Masukkan Bidang/Jurusan:");
  dosen.jurusan = stdin.readLineSync();

  print("\n=== Data Fakultas ===");
  Fakultas fakultas = Fakultas();
  print("Masukkan Nama Fakultas:");
  fakultas.namaFakultas = stdin.readLineSync();
  print("Masukkan Nama Pimpinan (Terkait):");
  fakultas.nama = stdin.readLineSync();

  print("\n--- OUTPUT ---");
  dosen.tampilkanData();
  print("");
  fakultas.tampilkanData();
}
