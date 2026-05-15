import 'cart_item.dart';

class Order {
  final int id;
  final List<CartItem> items;
  final int totalHarga;
  final DateTime tanggal;
  final String status;

  Order({
    required this.id,
    required this.items,
    required this.totalHarga,
    required this.tanggal,
    this.status = 'Diproses',
  });

  // Hitung total semua item (kalau mau dihitung ulang)
  int get hitungTotal =>
      items.fold(0, (sum, item) => sum + item.totalHarga);

  // Format tanggal jadi string yang rapi
  String get tanggalFormatted {
    return '${tanggal.day}/${tanggal.month}/${tanggal.year} '
        '${tanggal.hour.toString().padLeft(2, '0')}:'
        '${tanggal.minute.toString().padLeft(2, '0')}';
  }
}