import '../app_data.dart';
import '../models/product.dart';

class ProductController {

  // AMBIL semua produk
  List<Product> getDaftarProduk() {
    return daftarProduk;
  }

  // AMBIL produk berdasarkan ID
  Product? getProdukById(int id) {
    try {
      return daftarProduk.firstWhere((p) => p.id == id);
    } catch (e) {
      return null; // tidak ditemukan
    }
  }

  // CARI produk berdasarkan nama
  List<Product> cariProduk(String keyword) {
    if (keyword.isEmpty) return daftarProduk;

    return daftarProduk.where((p) =>
      p.nama.toLowerCase().contains(keyword.toLowerCase())
    ).toList();
  }

  // FILTER produk berdasarkan kategori
  List<Product> filterKategori(String kategori) {
    if (kategori == 'Semua') return daftarProduk;

    return daftarProduk.where((p) =>
      p.kategori == kategori
    ).toList();
  }

  // AMBIL semua kategori yang tersedia (untuk filter)
  List<String> getKategori() {
    List<String> kategori = ['Semua'];
    for (var p in daftarProduk) {
      if (!kategori.contains(p.kategori)) {
        kategori.add(p.kategori);
      }
    }
    return kategori;
  }

  // FORMAT harga jadi rupiah (contoh: 350000 → "Rp 350.000")
  String formatHarga(int harga) {
    String hargaStr = harga.toString();
    String hasil = '';
    int counter = 0;

    for (int i = hargaStr.length - 1; i >= 0; i--) {
      if (counter > 0 && counter % 3 == 0) {
        hasil = '.$hasil';
      }
      hasil = hargaStr[i] + hasil;
      counter++;
    }

    return 'Rp $hasil';
  }
}