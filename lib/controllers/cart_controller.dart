import '../app_data.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartController {

  // AMBIL semua item di keranjang
  List<CartItem> getKeranjang() {
    return keranjang;
  }

  // CEK apakah keranjang kosong
  bool isEmpty() {
    return keranjang.isEmpty;
  }

  // TAMBAH produk ke keranjang
  void tambahKeKeranjang(Product product) {
    // Cek apakah produk sudah ada di keranjang
    int index = _cariIndex(product.id);

    if (index != -1) {
      // Sudah ada → tambah jumlahnya saja
      keranjang[index].jumlah++;
    } else {
      // Belum ada → tambah item baru
      keranjang.add(CartItem(product: product));
    }
  }

  // KURANGI jumlah item (kalau jumlah jadi 0, hapus dari keranjang)
  void kurangiJumlah(int productId) {
    int index = _cariIndex(productId);
    if (index == -1) return;

    if (keranjang[index].jumlah > 1) {
      keranjang[index].jumlah--;
    } else {
      keranjang.removeAt(index);
    }
  }

  // HAPUS item dari keranjang berdasarkan index
  void hapusDariKeranjang(int index) {
    if (index >= 0 && index < keranjang.length) {
      keranjang.removeAt(index);
    }
  }

  // KOSONGKAN seluruh keranjang
  void kosongkanKeranjang() {
    keranjang.clear();
  }

  // HITUNG total harga semua item di keranjang
  int hitungTotal() {
    return keranjang.fold(0, (sum, item) => sum + item.totalHarga);
  }

  // HITUNG total jumlah item (untuk badge ikon keranjang)
  int hitungJumlahItem() {
    return keranjang.fold(0, (sum, item) => sum + item.jumlah);
  }

  // CARI index item berdasarkan product id (helper internal)
  int _cariIndex(int productId) {
    for (int i = 0; i < keranjang.length; i++) {
      if (keranjang[i].product.id == productId) {
        return i;
      }
    }
    return -1; // tidak ditemukan
  }
}