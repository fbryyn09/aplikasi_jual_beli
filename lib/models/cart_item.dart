import 'product.dart';

class CartItem {
  final Product product;
  int jumlah;

  CartItem({
    required this.product,
    this.jumlah = 1,
  });

  // Total harga item ini (harga × jumlah)
  int get totalHarga => product.harga * jumlah;
}