import '../app_data.dart';
import '../models/order.dart';
import 'cart_controller.dart';

class OrderController {
  final CartController _cartController = CartController();

  // AMBIL semua riwayat pesanan
  List<Order> getRiwayat() {
    return riwayatPesanan;
  }

  // CEK apakah ada riwayat pesanan
  bool adaRiwayat() {
    return riwayatPesanan.isNotEmpty;
  }

  // CHECKOUT — pindahkan keranjang ke riwayat pesanan
  // Kembalikan pesan error (string), null kalau berhasil
  String? checkout() {
    // Cek keranjang tidak kosong
    if (_cartController.isEmpty()) {
      return 'Keranjang masih kosong!';
    }

    // Buat order baru dari isi keranjang
    int idBaru = riwayatPesanan.length + 1;
    Order orderBaru = Order(
      id: idBaru,
      items: List.from(keranjang), // copy list, bukan reference
      totalHarga: _cartController.hitungTotal(),
      tanggal: DateTime.now(),
      status: 'Diproses',
    );

    // Simpan ke riwayat
    riwayatPesanan.add(orderBaru);

    // Kosongkan keranjang setelah checkout
    _cartController.kosongkanKeranjang();

    return null; // null = berhasil
  }

  // AMBIL order berdasarkan ID
  Order? getOrderById(int id) {
    try {
      return riwayatPesanan.firstWhere((o) => o.id == id);
    } catch (e) {
      return null;
    }
  }

  // FORMAT harga jadi rupiah
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