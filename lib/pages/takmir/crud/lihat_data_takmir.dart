import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/header.dart';
import 'package:e_mosque/components/custom_buttom_navigation_bar.dart';

class LihatTakmirScreen extends StatelessWidget {
  const LihatTakmirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
                          radius: 50,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDataRow('Jabatan', 'Ketua'),
                      const SizedBox(height: 10),
                      _buildDataRow('Nama Lengkap', 'Fulan'),
                      const SizedBox(height: 10),
                      _buildDataRow('Alamat', 'Jalan ...'),
                      const SizedBox(height: 10),
                      _buildDataRow('No. Telepon / HP', '08123456789'),
                      const SizedBox(height: 10),
                      _buildDataRow('Email', 'fulan@example.com'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan satu baris data
  Widget _buildDataRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130, 
          child: Text(
            '$label:',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
