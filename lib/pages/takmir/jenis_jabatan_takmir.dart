import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/pages/takmir/crud/edit_jenis_jabatan.dart';
import 'package:e_mosque/pages/takmir/crud/tambah_data_takmir.dart';
import 'package:e_mosque/pages/takmir/crud/tambah_jenis_jabatan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JenisJabatanTakmir extends StatefulWidget {
  @override
  _JenisJabatanTakmirState createState() => _JenisJabatanTakmirState();
}

class _JenisJabatanTakmirState extends State<JenisJabatanTakmir> {
  final List<Map<String, String>> _jabatanData = [
    {
      'nama_jabatan': 'Ketua',
      'level': 'Level 1',
    },
    {
      'nama_jabatan': 'Bendahara',
      'level': 'Level 2',
    },
    {
      'nama_jabatan': 'Sekretaris',
      'level': 'Level 2',
    },
    {
      'nama_jabatan': 'Anggota',
      'level': 'Level 3',
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
              itemCount: _jabatanData.length,
              itemBuilder: (context, index) {
                final jabatan = _jabatanData[index];
                return _buildJabatanCard(
                  jabatan['nama_jabatan']!,
                  jabatan['level']!,
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
                        builder: (context) => TambahJabatanScreen()),
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
                      'Tambah Jabatan',
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
          SizedBox(height: 40)
        ],
      ),
    );
  }

  // Widget untuk menampilkan card jenis jabatan takmir dengan tombol Edit di pojok kanan atas
  Widget _buildJabatanCard(String namaJabatan, String level) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  Text(
                    namaJabatan,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Level: $level',
                    style: GoogleFonts.poppins(fontSize: 14),
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
                          builder: (context) => EditJabatanScreen(),
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
