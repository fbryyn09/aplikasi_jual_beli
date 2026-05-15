import 'package:flutter/material.dart';
import '../models/product.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';

class DetailProdukScreen extends StatelessWidget {
  final Product product;
  const DetailProdukScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartCtrl    = CartController();
    final productCtrl = ProductController();

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey.shade100,
              child: Center(
                child: Text(
                  product.emoji,
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama & kategori
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.nama,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.kategori,
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Harga
                  Text(
                    productCtrl.formatHarga(product.harga),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Status stok
                  Row(
                    children: [
                      Icon(
                        product.stok > 0
                            ? Icons.check_circle
                            : Icons.cancel,
                        color:
                            product.stok > 0 ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.stok > 0
                            ? 'Stok tersedia (${product.stok})'
                            : 'Stok habis',
                        style: TextStyle(
                          color: product.stok > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Divider(),
                  const SizedBox(height: 8),

                  // Deskripsi
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.deskripsi,
                    style: const TextStyle(
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 100), // ruang untuk tombol bawah
                ],
              ),
            ),
          ],
        ),
      ),

      // Tombol tambah ke keranjang (sticky di bawah)
      bottomNavigationBar: Container(
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
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: product.stok > 0
                ? () {
                    cartCtrl.tambahKeKeranjang(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${product.nama} ditambahkan ke keranjang!'),
                        backgroundColor: Colors.green,
                        action: SnackBarAction(
                          label: 'Lihat Keranjang',
                          textColor: Colors.white,
                          onPressed: () => Navigator.pushNamed(
                              context, '/keranjang'),
                        ),
                      ),
                    );
                  }
                : null,
            icon: const Icon(Icons.shopping_cart),
            label: Text(
              product.stok > 0 ? 'Tambah ke Keranjang' : 'Stok Habis',
            ),
          ),
        ),
      ),
    );
  }
}