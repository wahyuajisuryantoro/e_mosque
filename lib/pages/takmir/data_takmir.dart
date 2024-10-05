import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/pages/takmir/crud/edit_data_takmir.dart';
import 'package:e_mosque/pages/takmir/crud/lihat_data_takmir.dart';
import 'package:e_mosque/pages/takmir/crud/tambah_data_takmir.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTakmir extends StatefulWidget {
  @override
  _DataTakmirState createState() => _DataTakmirState();
}

class _DataTakmirState extends State<DataTakmir> {
  final List<Map<String, String>> _takmirData = [
    {
      'nama': 'Ahmad Maulana',
      'no_hp': '08123456789',
      'jabatan': 'Ketua',
    },
    {
      'nama': 'Budi Setiawan',
      'no_hp': '08234567890',
      'jabatan': 'Bendahara',
    },
    {
      'nama': 'Siti Aminah',
      'no_hp': '08345678901',
      'jabatan': 'Sekretaris',
    },
    {
      'nama': 'Rudi Hartono',
      'no_hp': '08456789012',
      'jabatan': 'Anggota',
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
              itemCount: _takmirData.length,
              itemBuilder: (context, index) {
                final takmir = _takmirData[index];
                return _buildTakmirCard(
                  takmir['nama']!,
                  takmir['no_hp']!,
                  takmir['jabatan']!,
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                        builder: (context) => TambahTakmirScreen()),
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
                      'Tambah Takmir',
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
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Widget _buildTakmirCard(String nama, String noHp, String jabatan) {
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
                            'assets/images/user.png'), // Gambar lokal
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jabatan,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(nama,
                                style: GoogleFonts.poppins(fontSize: 14)),
                            Text('No. HP: $noHp',
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
                          builder: (context) => EditTakmirScreen(),
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
