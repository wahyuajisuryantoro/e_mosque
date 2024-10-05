import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/custom_buttom_navigation_bar.dart'; // Import Custom Navigation Bar

class LihatDataJamaahScreen extends StatefulWidget {
  @override
  _LihatDataJamaahScreenState createState() => _LihatDataJamaahScreenState();
}

class _LihatDataJamaahScreenState extends State<LihatDataJamaahScreen> {
  int _selectedIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Container(
                      width: 150, 
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Icon(
                            Icons.person, 
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Data Jamaah
                          _buildInfoRow("Nama", "Budi"),
                          _buildInfoRow("No. KTP", "1234567890123456"),
                          _buildInfoRow("Tempat Lahir", "Yogyakarta"),
                          _buildInfoRow("Tanggal Lahir", "0000-00-00"),
                          _buildInfoRow("Jenis Kelamin", "L"),
                          _buildInfoRow("Golongan Darah", "A"),
                          _buildInfoRow("Status Marital", "Menikah"),
                          _buildInfoRow("Pekerjaan", "PNS"),
                          _buildInfoRow("Status Ekonomi", "Mampu"),
                          _buildInfoRow("Status Jamaah", "Jamaah"),
                          _buildInfoRow("Alamat", "Jl. Malioboro No. 10"),
                          _buildInfoRow("Kabupaten", "Yogyakarta"),
                          _buildInfoRow("Telepon", "08919191010"),
                          _buildInfoRow("Email", "budi@email.com"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan data per baris dengan justify
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
