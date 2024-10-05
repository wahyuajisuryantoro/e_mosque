import 'package:e_mosque/pages/keuangan/transaksi/detail_transaksi.dart';
import 'package:e_mosque/pages/keuangan/transaksi/edit_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; // Pastikan komponen AppColors sudah ada

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({Key? key}) : super(key: key);

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
                  _buildTransaksiCard(
                    context,
                    1,
                    '2024-08-31',
                    'Donasi Pak Mansur',
                    'Bank BRI',
                    'PJ - Pemasukan Jumat',
                    '5,000,000',
                    '',
                  ),
                  _buildTransaksiCard(
                    context,
                    2,
                    '2024-08-31',
                    'Ceraj Banner Pelatihan',
                    'Kas Genzi',
                    '203 - operasional',
                    '',
                    '500,000',
                  ),
                  _buildTransaksiCard(
                    context,
                    3,
                    '2024-08-31',
                    'Sisa Donasi Pak Mansur',
                    'Bank BRI',
                    'TB - Pindah Buku (Masuk)',
                    '100,000',
                    '',
                  ),
                  _buildTransaksiCard(
                    context,
                    4,
                    '2024-08-31',
                    'Sisa Donasi Pak Mansur',
                    'Kas',
                    'TB - Pindah Buku (Keluar)',
                    '',
                    '100,000',
                  ),
                  _buildTransaksiCard(
                    context,
                    5,
                    '2024-08-29',
                    'Pemasukan Jumat',
                    'Bank BRI',
                    'PJ - Pemasukan Jumat',
                    '1,250,000',
                    '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun card transaksi
  Widget _buildTransaksiCard(
      BuildContext context,
      int no,
      String tanggal,
      String keterangan,
      String bukuKas,
      String akunTransaksi,
      String debit,
      String kredit) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailTransaksiPage()));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No: $no',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tanggal: $tanggal',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Text(
                    'Keterangan: $keterangan',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Text(
                    'Buku Kas: $bukuKas',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Text(
                    'Akun Transaksi: $akunTransaksi',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Text(
                    'Debit: $debit',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Text(
                    'Kredit: $kredit',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  color: AppColors
                      .primaryGradient.colors.first, // Warna tombol edit
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditTransaksiPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
