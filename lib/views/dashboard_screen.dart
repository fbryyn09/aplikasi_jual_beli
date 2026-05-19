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
  late final ProductController _productCtrl;
  late final AuthController _authCtrl;
  late final CartController _cartCtrl;

  List<Product> _produkDitampilkan = [];
  String _kategoriDipilih = 'Semua';
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    _productCtrl = ProductController();
    _authCtrl = AuthController();
    _cartCtrl = CartController();

    _produkDitampilkan = _productCtrl.getDaftarProduk();
  }

  void _cariProduk(String keyword) {
    setState(() {
      _produkDitampilkan = _productCtrl.cariProduk(keyword);
    });
  }

  void _filterKategori(String kategori) {
    setState(() {
      _kategoriDipilih = kategori;
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

  // ================= DRAWER =================
  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            accountName: Text(_authCtrl.getNamaUser()),
            accountEmail: const Text('user@gmail.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),

          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Keranjang'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/keranjang');
            },
          ),

          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Riwayat'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/riwayat');
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context);
              _logout();
            },
          ),
        ],
      ),
    );
  }

  // ================= CARD PRODUK =================
  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailProdukScreen(product: product),
          ),
        ).then((_) => setState(() {}));
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

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final kategoriList = _productCtrl.getKategori();

    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: Text('Halo, ${_authCtrl.getNamaUser()} 👋'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/notifikasi');
            },
          ),
        ],
      ),

      body: Column(
        children: [
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