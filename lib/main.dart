import 'package:flutter/material.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart';
import 'views/dashboard_screen.dart';
import 'views/keranjang_screen.dart';
import 'views/riwayat_screen.dart';

void main() {
  runApp(const TokoApp());
}

class TokoApp extends StatelessWidget {
  const TokoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Online',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto',

        // Styling AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),

        // Styling ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),

        // Styling InputDecoration (TextField)
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),

      // Halaman pertama saat buka aplikasi
      initialRoute: '/login',

      // Daftar semua halaman
      routes: {
        '/login':     (_) => const LoginScreen(),
        '/register':  (_) => const RegisterScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/keranjang': (_) => const KeranjangScreen(),
        '/riwayat':   (_) => const RiwayatScreen(),
      },

      // DetailProdukScreen tidak di sini karena butuh parameter Product
      // Navigasinya pakai MaterialPageRoute (lihat di dashboard_screen.dart)
    );
  }
}