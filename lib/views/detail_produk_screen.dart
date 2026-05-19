import 'package:flutter/material.dart';
import '../models/product.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';

class DetailProdukScreen extends StatelessWidget {
  final Product product;
  const DetailProdukScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartCtrl = CartController();
    final productCtrl = ProductController();

    return Scaffold(
      backgroundColor: const Color(0xFFF4EDE6),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // BAGIAN ATAS GAMBAR PRODUK
                  Container(
                    height: 370,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4EDE6),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              product.gambar,
                              height: 280,
                              width: 280,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Tombol back
                        Positioned(
                          top: 16,
                          left: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),

                        // Tombol favorit
                        Positioned(
                          top: 16,
                          right: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // BAGIAN DETAIL PUTIH
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(22, 26, 22, 120),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(34),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.kategori,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.nama,
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 4),
                            const Text('4.5'),
                          ],
                        ),

                        const SizedBox(height: 22),

                        const Text(
                          'Product Details',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          product.deskripsi,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 22),

                        const Text(
                          'Status Stok',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          product.stok > 0
                              ? 'Stok tersedia (${product.stok})'
                              : 'Stok habis',
                          style: TextStyle(
                            color: product.stok > 0
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // BOTTOM BAR
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(22, 14, 22, 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            productCtrl.formatHarga(product.harga),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 52,
                      width: 180,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5E3C),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        onPressed: product.stok > 0
                            ? () {
                                cartCtrl.tambahKeKeranjang(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${product.nama} ditambahkan ke keranjang!',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            : null,
                        icon: const Icon(Icons.shopping_bag),
                        label: Text(
                          product.stok > 0 ? 'Add to Cart' : 'Stok Habis',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}