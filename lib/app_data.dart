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
    gambar: 'assets/images/sepatu_nike.jpg',
    deskripsi: 'Sepatu olahraga Nike berkualitas tinggi.',
    kategori: 'Sepatu',
    stok: 10,
  ),

  Product(
    id: 2,
    nama: 'Kaos Polos',
    harga: 85000,
    gambar: 'assets/images/kaos_polos.jpg',
    deskripsi: 'Kaos polos bahan cotton combed 30s.',
    kategori: 'Pakaian',
    stok: 25,
  ),

  Product(
    id: 3,
    nama: 'Celana Jeans',
    harga: 200000,
    gambar: 'assets/images/celana_jeans.jpg',
    deskripsi: 'Celana jeans slim fit bahan denim premium.',
    kategori: 'Pakaian',
    stok: 15,
  ),

  Product(
    id: 4,
    nama: 'Tas Ransel',
    harga: 450000,
    gambar: 'assets/images/tas_ransel.jpg',
    deskripsi: 'Tas ransel anti air kapasitas 30L.',
    kategori: 'Tas',
    stok: 8,
  ),

  Product(
    id: 5,
    nama: 'Topi Baseball',
    harga: 75000,
    gambar: 'assets/images/Topi_Baseball.jpg',
    deskripsi: 'Topi baseball adjustable berbagai warna.',
    kategori: 'Aksesoris',
    stok: 20,
  ),

  Product(
    id: 6,
    nama: 'Jam Tangan',
    harga: 550000,
    gambar: 'assets/images/jam_Tangan.jpg',
    deskripsi: 'Jam tangan analog minimalis tahan air.',
    kategori: 'Aksesoris',
    stok: 5,
  ),

  Product(
    id: 7,
    nama: 'Sneakers Converse',
    harga: 320000,
    gambar: 'assets/images/Sneakers_Converse.jpg',
    deskripsi: 'Sneakers casual trendy dan nyaman dipakai sehari-hari.',
    kategori: 'Sepatu',
    stok: 12,
  ),

  Product(
    id: 8,
    nama: 'Sling Bag',
    harga: 180000,
    gambar: 'assets/images/Sling_Bag.jpg',
    deskripsi: 'Tas sling bag simple dan stylish untuk outfit harian.',
    kategori: 'Tas',
    stok: 7,
  ),

  Product(
    id: 9,
    nama: 'Hoodie Oversize',
    harga: 250000,
    gambar: 'assets/images/Hoodie_Oversize.jpg',
    deskripsi: 'Hoodie oversize bahan fleece premium dan nyaman.',
    kategori: 'Pakaian',
    stok: 30,
  ),

  Product(
    id: 10,
    nama: 'Kacamata Fashion',
    harga: 120000,
    gambar: 'assets/images/Kacamata_Fashion.jpg',
    deskripsi: 'Kacamata fashion stylish dan nyaman dipakai.',
    kategori: 'Aksesoris',
    stok: 18,
  ),
];

// ── DATA USER DUMMY ────────────────────────────────
List<User> daftarUser = [
  User(id: 1, nama: 'Admin', email: 'admin@toko.com', password: '123456'),
  User(id: 2, nama: 'Budi', email: 'budi@gmail.com', password: 'budi123'),
];

// ── DATA RUNTIME ───────────────────────────────────
User? userLogin;
List<CartItem> keranjang = [];
List<Order> riwayatPesanan = [];