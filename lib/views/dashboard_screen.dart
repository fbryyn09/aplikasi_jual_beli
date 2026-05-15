import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart';
import 'detail_produk_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _productCtrl = ProductController();
  final _authCtrl    = AuthController();
  final _cartCtrl    = CartController();

  List<Product> _produkDitampilkan = [];
  String _kategoriDipilih = 'Semua';
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _produkDitampilkan = _productCtrl.getDaftarProduk();
  }

  void _cariProduk(String keyword) {
    setState(() {
      _produkDitampilkan = _productCtrl.cariProduk(keyword);
    });
  }

  void _filterKategori(String kategori) {
    setState(() {
      _kategoriDipilih   = kategori;
      _produkDitampilkan = _productCtrl.filterKategori(kategori);
    });
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Yakin mau keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _authCtrl.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // ─── Widget kartu produk — digabung langsung di sini ───────────
  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailProdukScreen(product: product),
          ),
        ).then((_) => setState(() {})); // refresh badge keranjang saat kembali
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji produk
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    product.emoji,
                    style: const TextStyle(fontSize: 52),
                  ),
                ),
              ),
            ),

            // Info produk
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _productCtrl.formatHarga(product.harga),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Stok: ${product.stok}',
                    style: TextStyle(
                      color: product.stok > 0 ? Colors.grey : Colors.red,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final kategoriList = _productCtrl.getKategori();

    return Scaffold(
      appBar: AppBar(
        title: Text('Halo, ${_authCtrl.getNamaUser()} 👋'),
        actions: [
          // Ikon keranjang dengan badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () async {
                  await Navigator.pushNamed(context, '/keranjang');
                  setState(() {});
                },
              ),
              if (_cartCtrl.hitungJumlahItem() > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${_cartCtrl.hitungJumlahItem()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Ikon riwayat
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined),
            onPressed: () => Navigator.pushNamed(context, '/riwayat'),
          ),

          // Ikon logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),

      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: _cariProduk,
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          _cariProduk('');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Filter kategori
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: kategoriList.length,
              itemBuilder: (_, i) {
                final kat = kategoriList[i];
                final dipilih = kat == _kategoriDipilih;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(kat),
                    selected: dipilih,
                    onSelected: (_) => _filterKategori(kat),
                    selectedColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: dipilih ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Grid produk — langsung pakai _buildProductCard
          Expanded(
            child: _produkDitampilkan.isEmpty
                ? const Center(
                    child: Text(
                      'Produk tidak ditemukan 😕',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: _produkDitampilkan.length,
                    itemBuilder: (_, i) =>
                        _buildProductCard(_produkDitampilkan[i]),
                  ),
          ),
        ],
      ),
    );
  }
}