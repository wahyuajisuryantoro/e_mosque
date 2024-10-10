import 'package:e_mosque/pages/keuangan/buku_kas/detail_buku_kas.dart';
import 'package:e_mosque/pages/keuangan/buku_kas/edit_buku_kas.dart';
import 'package:e_mosque/pages/keuangan/buku_kas/tambah_buku_kas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';

class BukuKasPage extends StatelessWidget {
  final List<Map<String, String>> bukuKasData = [
    {
      'no': '4',
      'nama': 'Kas Genzi',
      'deskripsi': 'Kas untuk kegiatan genzi',
      'saldo_awal': '5.000.000',
      'saldo_sekarang': '4.500.000'
    },
    {
      'no': '3',
      'nama': 'Kas Ditangan',
      'deskripsi': 'Kas Ditangan',
      'saldo_awal': '1.500.000',
      'saldo_sekarang': '1.750.000'
    },
    {
      'no': '2',
      'nama': 'Bank BRI',
      'deskripsi': 'Kas di rekening bank BRI',
      'saldo_awal': '5.000.000',
      'saldo_sekarang': '11.750.000'
    },
    {
      'no': '1',
      'nama': 'Bank Mandiri',
      'deskripsi': 'Kas di rekening bank Mandiri',
      'saldo_awal': '3.000.000',
      'saldo_sekarang': '3.000.000'
    },
  ];

  BukuKasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: bukuKasData.length,
                itemBuilder: (context, index) {
                  final bukuKas = bukuKasData[index];
                  return _buildBukuKasCard(context, bukuKas);
                },
              ),
            ),
            _buildTambahButton(context),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }

  Widget _buildBukuKasCard(BuildContext context, Map<String, String> bukuKas) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBukuKasPage(),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bukuKas['nama']!,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bukuKas['deskripsi']!,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow('Saldo Awal', bukuKas['saldo_awal']!),
                  _buildInfoRow('Saldo Sekarang', bukuKas['saldo_sekarang']!),
                ],
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
                        // Navigasi ke halaman edit dengan data bukuKas
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditBukuKasPage(),
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
      ),
    );
  }

  // Fungsi untuk menampilkan informasi Saldo
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun tombol tambah
  Widget _buildTambahButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TambahBukuKasPage()));
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Tambah Buku Kas',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
