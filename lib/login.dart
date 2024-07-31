import 'package:flutter/material.dart';
import 'inputAbsen.dart'; // Pastikan file ini ada dan diimpor dengan benar

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkFormValidity);
    _passwordController.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    setState(() {
      _isButtonEnabled = _nameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _login() {
    final name = _nameController.text;
    final password = _passwordController.text;

    if (name.isNotEmpty && password.isNotEmpty) {
      // Proses login, misalnya validasi atau kirim data ke server
      print('Nama: $name');
      print('Password: $password');

      // Arahkan ke halaman InputAbsenPage setelah login berhasil
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InputAbsenPage(name: name),
        ),
      );

      // Bersihkan form setelah login
      _nameController.clear();
      _passwordController.clear();
    } else {
      // Tampilkan pesan error atau notifikasi jika nama atau password kosong
      print('Nama dan Password tidak boleh kosong');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Text(
                "Welcome!",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              const Text(
                "Silahkan login untuk melanjutkan",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity, // Tombol selebar layar
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _login : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
