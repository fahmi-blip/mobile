import 'dart:io';

void main() {
  Map<String, String> data = {
    'Anang': '081234567890',
    'Arman': '082345678901',
    'Doni': '083456789012',
  };
  print('Data: $data');

  data['Rio'] = '084567890123';
  print('Data setelah ditambahkan: $data');

  print('Nomor Anang: ${data['Anang']}');

  print('\n=== INPUT DATA MAHASISWA ===');
  stdout.write("Masukkan NIM: ");
  String? inputNIM = stdin.readLineSync();
  stdout.write("Masukkan Nama: ");
  String? inputNama = stdin.readLineSync();
  stdout.write("Masukkan Jurusan: ");
  String? inputJurusan = stdin.readLineSync();
  stdout.write("Masukkan IPK: ");
  String? inputIPK = stdin.readLineSync();

  if (inputNIM != null &&
      inputNama != null &&
      inputJurusan != null &&
      inputIPK != null) {
    Map<String, String> mahasiswa = {
      'NIM': inputNIM,
      'Nama': inputNama,
      'Jurusan': inputJurusan,
      'IPK': inputIPK,
    };
    print('Data Mahasiswa: $mahasiswa');
  } else {
    print('Input tidak lengkap. Data mahasiswa tidak dapat dibuat.');
  }
  
  print('\n=== INPUT MULTIPLE MAHASISWA ===');
  stdout.write("Masukkan Jumlah mahasiswa: ");
  String? inputJumlah = stdin.readLineSync();


  int jumlah = int.tryParse(inputJumlah ?? '') ?? 0;
  List<Map<String, String>> mahasiswaList = [];
  for (int i = 0; i < jumlah; i++) {
    
    print('\n--- Mahasiswa ke-${i + 1} ---');
    stdout.write("Masukkan NIM: ");
    String? nim = stdin.readLineSync();
    stdout.write("Masukkan Nama: ");
    String? nama = stdin.readLineSync();
    stdout.write("Masukkan Jurusan: ");
    String? jurusan = stdin.readLineSync();
    stdout.write("Masukkan IPK: ");
    String? ipk = stdin.readLineSync();

    if (nim != null && nama != null && jurusan != null && ipk != null) {
      Map<String, String> mahasiswa = {
        'Masukkan NIM': nim,
        'Masukkan Nama': nama,
        'Masukkan Jurusan': jurusan,
        'Masukkan IPK': ipk,
      };
      mahasiswaList.add(mahasiswa);
    } else {
      print('Input tidak lengkap untuk mahasiswa ke-${i + 1}. Data tidak ditambahkan.');
    }
  }
  
}
