import 'package:flutter/material.dart';
import '../controllers/order_controller.dart';
import '../controllers/product_controller.dart';
import '../models/order.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderCtrl   = OrderController();
    final productCtrl = ProductController();
    final riwayat     = orderCtrl.getRiwayat();

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pesanan')),
      body: riwayat.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('📦',
                      style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada pesanan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Yuk mulai belanja!',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(
                            context, '/dashboard'),
                    child: const Text('Mulai Belanja'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              // Tampilkan pesanan terbaru di atas
              itemCount: riwayat.length,
              itemBuilder: (_, i) {
                final Order order =
                    riwayat[riwayat.length - 1 - i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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
                  child: Column(
                    children: [
                      // Header order
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pesanan #${order.id}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                order.status,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tanggal
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              order.tanggalFormatted,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      // List item
                      ...order.items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                          child: Row(
                            children: [
                              Text(item.product.emoji,
                                  style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${item.product.nama} x${item.jumlah}',
                                ),
                              ),
                              Text(
                                productCtrl
                                    .formatHarga(item.totalHarga),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Divider(height: 20),

                      // Total
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              productCtrl
                                  .formatHarga(order.totalHarga),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}