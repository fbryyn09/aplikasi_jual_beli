import '../app_data.dart';
import '../models/user.dart';

class AuthController {

  // LOGIN
  // Kembalikan true kalau berhasil, false kalau gagal
  bool login(String email, String password) {
    // Cari user yang cocok dari daftar user
    User? user;
    for (var u in daftarUser) {
      if (u.email == email && u.password == password) {
        user = u;
        break;
      }
    }

    if (user != null) {
      // Simpan user yang login ke app_data
      userLogin = user;
      return true;
    }

    return false;
  }

  // REGISTER
  // Kembalikan pesan error (string), null kalau berhasil
  String? register(String nama, String email, String password) {
    // Validasi tidak boleh kosong
    if (nama.isEmpty || email.isEmpty || password.isEmpty) {
      return 'Semua kolom wajib diisi!';
    }

    // Validasi password minimal 6 karakter
    if (password.length < 6) {
      return 'Password minimal 6 karakter!';
    }

    // Cek email sudah terdaftar atau belum
    bool emailSudahAda = daftarUser.any((u) => u.email == email);
    if (emailSudahAda) {
      return 'Email sudah terdaftar!';
    }

    // Tambahkan user baru ke daftar
    int idBaru = daftarUser.length + 1;
    daftarUser.add(User(
      id: idBaru,
      nama: nama,
      email: email,
      password: password,
    ));

    return null; // null = berhasil, tidak ada error
  }

  // LOGOUT
  void logout() {
    userLogin = null;
    keranjang.clear();
    // riwayatPesanan tidak dikosongkan
    // supaya riwayat tetap ada kalau login lagi
  }

  // CEK apakah ada user yang sedang login
  bool isLoggedIn() {
    return userLogin != null;
  }

  // AMBIL nama user yang sedang login
  String getNamaUser() {
    return userLogin?.nama ?? 'Guest';
  }
}