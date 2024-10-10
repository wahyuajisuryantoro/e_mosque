import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/controllers/auth_controller.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/pages/auth/update_password.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyUsernameScreen extends StatefulWidget {
  const VerifyUsernameScreen({super.key});

  @override
  _VerifyUsernameScreenState createState() => _VerifyUsernameScreenState();
}

class _VerifyUsernameScreenState extends State<VerifyUsernameScreen> {
  final _usernameController = TextEditingController();
  final _authController = AuthController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _verifyUsername() async {
    String username = _usernameController.text.trim();

    if (username.isEmpty) {
      GlobalAlert.showAlert(
        context: context,
        title: "Kesalahan",
        message: "Username tidak boleh kosong.",
        type: AlertType.error,
      );
      return;
    }

    // Panggil fungsi verifikasi username dari controller
    bool isUsernameValid = await _authController.verifyUsername(username, context);

    if (isUsernameValid) {
      // Jika valid, arahkan ke halaman reset password
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => UpdatePasswordScreen(),
      //   ),
      // );
    }
    // Tidak perlu else karena pesan kesalahan ditangani oleh fungsi verifyUsername
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Dismiss keyboard
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Verifikasi Username',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Silakan masukkan username Anda untuk memulai proses reset password.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Username',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  buildTextField(
                    controller: _usernameController,
                    hintText: 'Enter your username',
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _verifyUsername,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.greenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Verifikasi Username',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.greenColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
