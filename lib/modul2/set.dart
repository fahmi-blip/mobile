import 'dart:io';

void main() {
  Set<String> data = {'a', 'b', 'c', 'd', 'e'};

  print("=== SEMUA DATA ===");
  int i = 1;
  for (String item in data) {
    print("$i. $item");
    i++;
  }
  print("Total data: ${data.length}");

  stdout.write("Masukkan data baru: ");
  String? input = stdin.readLineSync();
  if (input != null && input.isNotEmpty) {
    if (data.add(input)) {
      print('Data "$input" berhasil ditambahkan!');
    } else {
      print('Data "$input" sudah ada di Set!');
    }
  }
  stdout.write("Masukkan data yang ingin dihapus: ");
  String? delete = stdin.readLineSync();
  if (delete != null && delete.isNotEmpty) {
    if (data.remove(delete)) {
      print('Data "$delete" berhasil dihapus!');
    } else {
      print('Data "$delete" tidak ditemukan!');
    }
  }
  stdout.write("Masukkan data yang ingin dicek: ");
  String? check = stdin.readLineSync();
  if (check != null && check.isNotEmpty) {
    if (data.contains(check)) {
      print('Data "$check" ada di Set!');
    } else {
      print('Data "$check" tidak ada di Set!');
    }
  }
  print(data);
}
