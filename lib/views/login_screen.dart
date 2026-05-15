import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _authCtrl     = AuthController();

  bool _isLoading       = false;
  bool _passwordVisible = false;
  String? _errorMessage;

  void _login() async {
    // Sembunyikan keyboard
    FocusScope.of(context).unfocus();

    // Validasi tidak boleh kosong
    if (_emailCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) {
      setState(() => _errorMessage = 'Email dan password wajib diisi!');
      return;
    }

    setState(() {
      _isLoading    = true;
      _errorMessage = null;
    });

    // Simulasi loading sebentar
    await Future.delayed(const Duration(milliseconds: 500));

    bool berhasil = _authCtrl.login(
      _emailCtrl.text.trim(),
      _passwordCtrl.text.trim(),
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (berhasil) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() => _errorMessage = 'Email atau password salah!');
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),

              // Logo & judul
              const Text(
                '🛍️',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 64),
              ),
              const SizedBox(height: 16),
              const Text(
                'Toko Online',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Text(
                'Masuk ke akun kamu',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // Pesan error
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Field email
              TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Field password
              TextField(
                controller: _passwordCtrl,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => setState(
                      () => _passwordVisible = !_passwordVisible,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Tombol login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Login'),
                ),
              ),
              const SizedBox(height: 16),

              // Link ke register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun? '),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, '/register'),
                    child: const Text(
                      'Daftar di sini',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Info akun demo
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '💡 Akun Demo:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('Email    : admin@toko.com'),
                    Text('Password : 123456'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}