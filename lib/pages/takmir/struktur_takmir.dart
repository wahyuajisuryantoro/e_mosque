import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/header.dart';
import 'package:e_mosque/components/custom_buttom_navigation_bar.dart';

class StrukturTakmir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'STRUKTUR PENGURUS\nMasjid An Nur',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        _buildJabatanRow(
                          jabatan: 'Ketua',
                          nama: 'Fulan',
                          imageUrl: 'assets/images/user.png',
                        ),
                        SizedBox(height: 10),

                        _buildJabatanRow(
                          jabatan: 'Bendahara',
                          nama: 'M. Fulan',
                          imageUrl: 'assets/images/user.png',
                        ),
                        SizedBox(height: 10),

                        _buildJabatanRow(
                          jabatan: 'Sekretaris',
                          nama: 'Fulanah',
                          imageUrl: 'assets/images/user.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun baris jabatan, nama, dan foto
  Widget _buildJabatanRow({
    required String jabatan,
    required String nama,
    required String imageUrl,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '$jabatan:',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(imageUrl),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Text(
            nama,
            style: GoogleFonts.poppins(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
