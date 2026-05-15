import 'models/product.dart';
import 'models/cart_item.dart';
import 'models/order.dart';
import 'models/user.dart';

// ── DATA PRODUK DUMMY ──────────────────────────────
List<Product> daftarProduk = [
  Product(
    id: 1,
    nama: 'Sepatu Nike',
    harga: 350000,
    emoji: '👟',
    deskripsi: 'Sepatu olahraga Nike berkualitas tinggi, nyaman dipakai sehari-hari maupun berolahraga.',
    kategori: 'Sepatu',
    stok: 10,
  ),
  Product(
    id: 2,
    nama: 'Kaos Polos',
    harga: 85000,
    emoji: '👕',
    deskripsi: 'Kaos polos bahan cotton combed 30s, adem dan tidak mudah kusut.',
    kategori: 'Pakaian',
    stok: 25,
  ),
  Product(
    id: 3,
    nama: 'Celana Jeans',
    harga: 200000,
    emoji: '👖',
    deskripsi: 'Celana jeans slim fit bahan denim premium, cocok untuk berbagai kesempatan.',
    kategori: 'Pakaian',
    stok: 15,
  ),
  Product(
    id: 4,
    nama: 'Tas Ransel',
    harga: 450000,
    emoji: '🎒',
    deskripsi: 'Tas ransel anti air kapasitas 30L, cocok untuk kuliah maupun traveling.',
    kategori: 'Tas',
    stok: 8,
  ),
  Product(
    id: 5,
    nama: 'Topi Baseball',
    harga: 75000,
    emoji: '🧢',
    deskripsi: 'Topi baseball bahan canvas, adjustable, tersedia berbagai warna.',
    kategori: 'Aksesoris',
    stok: 20,
  ),
  Product(
    id: 6,
    nama: 'Jam Tangan',
    harga: 550000,
    emoji: '⌚',
    deskripsi: 'Jam tangan analog minimalis, tahan air, cocok untuk pria maupun wanita.',
    kategori: 'Aksesoris',
    stok: 5,
  ),
];

// ── DATA USER DUMMY ────────────────────────────────
List<User> daftarUser = [
  User(id: 1, nama: 'Admin', email: 'admin@toko.com', password: '123456'),
  User(id: 2, nama: 'Budi', email: 'budi@gmail.com', password: 'budi123'),
];

// ── DATA RUNTIME (berubah saat aplikasi jalan) ─────
User? userLogin;          // user yang sedang login
List<CartItem> keranjang = [];
List<Order> riwayatPesanan = [];