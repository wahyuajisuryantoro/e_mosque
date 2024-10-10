import 'package:e_mosque/pages/inventaris/kategori_barang/edit_kategori_barang.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; // Asumsi AppColors didefinisikan di sini

class KategoriBarangPage extends StatefulWidget {
  const KategoriBarangPage({super.key});

  @override
  _KategoriBarangPageState createState() => _KategoriBarangPageState();
}

class _KategoriBarangPageState extends State<KategoriBarangPage> {
  final List<Map<String, String?>> kategoriData = [
    {
      'no': '1',
      'nama': 'Furniture',
      'deskripsi': 'Deskripsi untuk kategori Furniture'
    },
    {
      'no': '2',
      'nama': 'Fashion',
      'deskripsi': 'Deskripsi untuk kategori Fashion'
    },
    {'no': '3', 'nama': 'Elektronik', 'deskripsi': null}, // Deskripsi null
  ];

  String? _selectedKategori;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: kategoriData.length,
                itemBuilder: (context, index) {
                  final kategori = kategoriData[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_selectedKategori == kategori['nama']) {
                              _selectedKategori = null;
                            } else {
                              _selectedKategori = kategori['nama'];
                            }
                          });
                        },
                        child: _buildKategoriCard(kategori),
                      ),
                      if (_selectedKategori == kategori['nama'])
                        _buildDetailKategori(kategori),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKategoriCard(Map<String, String?> kategori) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Nomor kategori
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      kategori['no']!,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Nama kategori
                Text(
                  kategori['nama']!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.edit,
                  color: AppColors.primaryGradient.colors.first),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditKategoriBarangPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan detail kategori
  Widget _buildDetailKategori(Map<String, String?> kategori) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffb1feb1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama: ${kategori['nama']}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Deskripsi: ${kategori['deskripsi'] ?? "Tidak ada deskripsi"}',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
