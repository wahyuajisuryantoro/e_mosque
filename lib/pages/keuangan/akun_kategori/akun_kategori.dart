import 'package:e_mosque/pages/keuangan/akun_kategori/detail_akun_kategori.dart';
import 'package:e_mosque/pages/keuangan/akun_kategori/edit_akun_kategori.dart';
import 'package:e_mosque/pages/keuangan/akun_kategori/tambah_akun_kategori.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; // Pastikan komponen AppColors sudah ada

class AkunKategoriPage extends StatelessWidget {
  const AkunKategoriPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildAkunKategoriCard(
                      context, '203', 'Operasional', 'Pengeluaran'),
                  _buildAkunKategoriCard(
                      context, 'PJ', 'Pemasukan Jumat', 'Pemasukan'),
                  _buildAkunKategoriCard(
                      context, 'BR', 'Biaya Rumah Tangga', 'Pengeluaran'),
                ],
              ),
            ),
            _buildTambahButton(context),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  // Widget untuk setiap card akun/kategori
  Widget _buildAkunKategoriCard(
      BuildContext context, String kode, String nama, String position) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAkunKeuanganPage(),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kode: $kode',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Nama: $nama',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Position: $position',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  color: AppColors.primaryGradient.colors.first,
                  iconSize: 24,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditAkunKategoriPage()));
                  },
                ),
              ),
            ],
          ),
        ),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TambahAkunKategoriPage()));
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
              'Tambah Akun Kategoru',
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
