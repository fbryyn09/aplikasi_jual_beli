import 'package:flutter/material.dart';
import '../controllers/order_controller.dart';
import '../controllers/product_controller.dart';
import '../models/order.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderCtrl = OrderController();
    final productCtrl = ProductController();
    final riwayat = orderCtrl.getRiwayat();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      // APPBAR GRADASI BIRU
      appBar: AppBar(
        title: const Text(
          'Riwayat Pesanan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1565C0),
                Color(0xFF42A5F5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: riwayat.isEmpty
          ? _emptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: riwayat.length,
              itemBuilder: (context, i) {
              final Order order =
                  riwayat[riwayat.length - 1 - i];

                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      // HEADER TOKO GRADASI
                      Container(
                        padding:
                            const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF1565C0),
                              Color(0xFF64B5F6),
                            ],
                            begin: Alignment.topLeft,
                            end:
                                Alignment.bottomRight,
                          ),
                          borderRadius:
                              BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.storefront,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),

                            const Expanded(
                              child: Text(
                                'Toko Online',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration:
                                  BoxDecoration(
                                color: Colors.white24,
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  20,
                                ),
                              ),
                              child: Text(
                                order.status,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // TANGGAL
                      Padding(
                        padding:
                            const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 15,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              order
                                  .tanggalFormatted,
                              style:
                                  const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ITEM PESANAN
                      ...order.items.map((item) {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Row(
                            children: [

                              // ICON PRODUK
                              Container(
                                width: 58,
                                height: 58,
                                decoration:
                                    BoxDecoration(
                                  color:
                                      const Color(
                                    0xFFE3F2FD,
                                  ),
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    14,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    item.product
                                        .emoji,
                                    style:
                                        const TextStyle(
                                      fontSize:
                                          28,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                  width: 12),

                              // NAMA
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      item.product
                                          .nama,
                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .w600,
                                        fontSize:
                                            14,
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            4),
                                    Text(
                                      '${item.jumlah} barang',
                                      style:
                                          const TextStyle(
                                        color:
                                            Colors
                                                .grey,
                                        fontSize:
                                            12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // HARGA
                              Text(
                                productCtrl
                                    .formatHarga(
                                  item.totalHarga,
                                ),
                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),

                      const Divider(),

                      // TOTAL + BUTTON
                      Padding(
                        padding:
                            const EdgeInsets.all(12),
                        child: Column(
                          children: [

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .end,
                              children: [
                                const Text(
                                  'Total Pesanan : ',
                                  style:
                                      TextStyle(
                                    color:
                                        Colors
                                            .grey,
                                  ),
                                ),
                                Text(
                                  productCtrl
                                      .formatHarga(
                                    order
                                        .totalHarga,
                                  ),
                                  style:
                                      const TextStyle(
                                    color:
                                        Color(
                                      0xFF1565C0,
                                    ),
                                    fontSize:
                                        17,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                                height: 12),

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .end,
                              children: [

                                OutlinedButton(
                                  onPressed: () {},
                                  style:
                                      OutlinedButton
                                          .styleFrom(
                                    side:
                                        const BorderSide(
                                      color: Color(
                                        0xFF1565C0,
                                      ),
                                    ),
                                  ),
                                  child:
                                      const Text(
                                    'Detail',
                                    style:
                                        TextStyle(
                                      color:
                                          Color(
                                        0xFF1565C0,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                    width: 8),

                                Container(
                                  decoration:
                                      BoxDecoration(
                                    gradient:
                                        const LinearGradient(
                                      colors: [
                                        Color(
                                          0xFF1565C0,
                                        ),
                                        Color(
                                          0xFF64B5F6,
                                        ),
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      10,
                                    ),
                                  ),
                                  child:
                                      ElevatedButton(
                                    style:
                                        ElevatedButton
                                            .styleFrom(
                                      backgroundColor:
                                          Colors
                                              .transparent,
                                      shadowColor:
                                          Colors
                                              .transparent,
                                    ),
                                    onPressed:
                                        () {},
                                    child:
                                        const Text(
                                      'Beli Lagi',
                                      style:
                                          TextStyle(
                                        color:
                                            Colors
                                                .white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 90,
            color: Color(0xFF64B5F6),
          ),
          const SizedBox(height: 14),
          const Text(
            'Belum Ada Pesanan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Yuk mulai belanja sekarang',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFF1565C0),
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 12,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/dashboard',
              );
            },
            child: const Text(
              'Mulai Belanja',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}