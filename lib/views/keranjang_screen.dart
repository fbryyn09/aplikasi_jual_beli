import 'package:flutter/material.dart';
import '../controllers/cart_controller.dart';
import '../controllers/order_controller.dart';
import '../controllers/product_controller.dart';
import '../models/cart_item.dart';

class KeranjangScreen extends StatefulWidget {
  const KeranjangScreen({super.key});

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  final _cartCtrl    = CartController();
  final _orderCtrl   = OrderController();
  final _productCtrl = ProductController();

  void _tambahJumlah(int productId) {
    setState(() => _cartCtrl.tambahKeKeranjang(
          _cartCtrl.getKeranjang()
              .firstWhere((i) => i.product.id == productId)
              .product,
        ));
  }

  void _kurangiJumlah(int productId) {
    setState(() => _cartCtrl.kurangiJumlah(productId));
  }

  void _hapusItem(int index) {
    setState(() => _cartCtrl.hapusDariKeranjang(index));
  }

  void _checkout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi Pesanan'),
        content: Text(
          'Total pembayaran:\n'
          '${_productCtrl.formatHarga(_cartCtrl.hitungTotal())}\n\n'
          'Lanjutkan checkout?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              String? error = _orderCtrl.checkout();
              if (error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pesanan berhasil dibuat! 🎉'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pushReplacementNamed(context, '/riwayat');
              }
            },
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keranjang = _cartCtrl.getKeranjang();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        actions: [
          if (keranjang.isNotEmpty)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Kosongkan Keranjang'),
                    content: const Text(
                        'Yakin ingin menghapus semua item?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _cartCtrl.kosongkanKeranjang());
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Hapus Semua',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'Hapus Semua',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: keranjang.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🛒',
                      style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  const Text(
                    'Keranjang masih kosong',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Yuk tambahkan produk ke keranjang!',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(
                            context, '/dashboard'),
                    child: const Text('Belanja Sekarang'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // List item keranjang
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: keranjang.length,
                    itemBuilder: (_, i) {
                      final CartItem item = keranjang[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Emoji produk
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  item.product.emoji,
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Info produk
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.nama,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _productCtrl.formatHarga(
                                        item.product.harga),
                                    style: const TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    'Subtotal: ${_productCtrl.formatHarga(item.totalHarga)}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Kontrol jumlah
                            Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => _kurangiJumlah(
                                          item.product.id),
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Icon(Icons.remove,
                                            size: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        '${item.jumlah}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _tambahJumlah(
                                          item.product.id),
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Icon(Icons.add,
                                            size: 16,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: () => _hapusItem(i),
                                  child: const Text(
                                    'Hapus',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Total & tombol checkout
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Pembayaran:',
                              style: TextStyle(fontSize: 16)),
                          Text(
                            _productCtrl
                                .formatHarga(_cartCtrl.hitungTotal()),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _checkout,
                          child: const Text('Checkout Sekarang'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}