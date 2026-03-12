import 'dart:io';

void main() {
  // d
  List<String> names = ['Alice', 'Bob', 'Charlie'];
  print('Names: $names'); // Output: [Alice, Bob, Charlie]

  //e
  names.add('David');
  print('Nama setelah diubah: $names'); // Output: [Alice, Bob, Charlie, David]

  //f
  print('ELemen pertama: ${names[0]}'); // Output: Alice
  print('ELemen kedua: ${names[1]}'); // Output: Alice

  //g
  names[1] = 'Eve';
  print('Nama setelah diubah: $names'); // Output: [Alice, Eve,

  //h
  names.remove('Bob');
  print(names); // Output: [Alice, Charlie, David]

  //i
  print('Jumlah data: ${names.length}');

  // //j
  print('Menampilkan setiap elemen:');
  for (String name in names) {
    print(name);
  }

  // //l
  List<String> dataList = [];
  print('Data list kosong: $dataList');
  int count = 0;
  while (count <= 0) {
    stdout.write('Masukkan jumlah list: ');
    String? input = stdin.readLineSync();
    try {
      count = int.parse(input!);
      if (count <= 0) {
        print('Jumlah list harus lebih dari 0. Silakan coba lagi.');
      }
    } catch (e) {
      print('Input tidak valid. Silakan masukkan angka.');
    }
  }
  for (int i = 0; i < count; i++) {
    stdout.write('Masukkan data ke-${i + 1}: ');
    String x = stdin.readLineSync()!;
    dataList.add(x);
  }

  print('Data list:');
  // print(dataList);
  print('=== SEMUA DATA ===');
  // List<String> dataList = ['a', 'b', 'c', 'd'];
  for (String angka in dataList) {
    dataList[3] = 'f';
    dataList.remove('d');
    print('Index ${dataList.indexOf(angka)}: $angka');
  }
}
