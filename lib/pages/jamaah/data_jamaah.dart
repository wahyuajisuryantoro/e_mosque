
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/pages/jamaah/crud/edit_data_jamaah.dart';
import 'package:e_mosque/pages/jamaah/crud/tambah_data_jamaah.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataJamaahTab extends StatefulWidget {
  @override
  _DataJamaahTabState createState() => _DataJamaahTabState();
}

class _DataJamaahTabState extends State<DataJamaahTab> {
  String _selectedFilter = 'Semua';
  final List<String> _filters = [
    'Semua',
    'Mampu',
    'Kurang Mampu',
    'Tidak Mampu',
    'Menikah',
    'Belum Menikah',
    'Janda/Duda',
    'Golongan'
  ];

  final List<Map<String, String>> _jamaahData = [
    {
      'nama': 'Ahmad Maulana',
      'no_hp': '08123456789',
      'status': 'Mampu, Menikah',
    },
    {
      'nama': 'Budi Setiawan',
      'no_hp': '08234567890',
      'status': 'Kurang Mampu, Belum Menikah',
    },
    {
      'nama': 'Siti Aminah',
      'no_hp': '08345678901',
      'status': 'Tidak Mampu, Janda',
    },
    {
      'nama': 'Rudi Hartono',
      'no_hp': '08456789012',
      'status': 'Mampu, Belum Menikah',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _jamaahData.length,
              itemBuilder: (context, index) {
                final jamaah = _jamaahData[index];
                return _buildJamaahCard(
                  jamaah['nama']!,
                  jamaah['no_hp']!,
                  jamaah['status']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TambahJamaahScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Tambah Jamaah',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  // Widget untuk menampilkan card data jamaah dengan tombol Edit di pojok kanan atas
  Widget _buildJamaahCard(String nama, String noHp, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/images/user.png'), 
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nama,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('No. HP: $noHp',
                                style: GoogleFonts.poppins(fontSize: 14)),
                            SizedBox(height: 5,),
                            Text('Status: $status',
                                style: GoogleFonts.poppins(fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
           Positioned(
                top: 10,
                right: 0,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: AppColors.primaryGradient.colors.first,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditJamaahScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
