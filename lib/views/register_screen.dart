import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaCtrl     = TextEditingController();
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _authCtrl     = AuthController();

  bool _isLoading       = false;
  bool _passwordVisible = false;
  String? _errorMessage;

  void _register() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading    = true;
      _errorMessage = null;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    String? error = _authCtrl.register(
      _namaCtrl.text.trim(),
      _emailCtrl.text.trim(),
      _passwordCtrl.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (error != null) {
      // Ada error
      setState(() => _errorMessage = error);
    } else {
      // Berhasil → kembali ke login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Akun berhasil dibuat! Silakan login.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Daftar Akun')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Buat Akun Baru',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Isi data diri kamu di bawah ini',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),

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

              // Field nama
              TextField(
                controller: _namaCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person_outlined),
                ),
              ),
              const SizedBox(height: 16),

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
                  labelText: 'Password (min. 6 karakter)',
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
              const SizedBox(height: 32),

              // Tombol register
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Daftar Sekarang'),
                ),
              ),
              const SizedBox(height: 16),

              // Link kembali ke login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah punya akun? '),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Login di sini',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}