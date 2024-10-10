import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; 
import 'package:photo_view/photo_view.dart'; // Import package photo_view

class DetailTransaksiPage extends StatelessWidget {
  final String tanggalTransaksi = '2024-08-31';
  final String keterangan = 'Donasi Pak Mamsur';
  final String bukuKas = 'Bank BRI';
  final String akunTransaksi = 'Pemasukan - Pemasukan Jumat';
  final String debit = '5.000.000';
  final String kredit = '-';
  final String saldo = '3.000.000';
  final String buktiImageUrl = 'assets/images/bukti_transaksi.png';

  const DetailTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detail Transaksi',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card utama dengan detail transaksi
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal Transaksi:',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tanggalTransaksi,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow('Keterangan', keterangan),
                    _buildDetailRow('Buku Kas', bukuKas),
                    _buildDetailRow('Akun Transaksi', akunTransaksi),
                    _buildDetailRow('Debit', 'Rp $debit'),
                    _buildDetailRow('Kredit', kredit == '-' ? '-' : 'Rp $kredit'),
                    _buildDetailRow('Saldo', 'Rp $saldo'),

                    const SizedBox(height: 16),

                    // Bukti transaksi berupa foto
                    _buildBuktiTransaksi(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun baris detail transaksi
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun tampilan foto bukti transaksi
  Widget _buildBuktiTransaksi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bukti Transaksi:',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GestureDetector(
            onTap: () {
              // Aksi untuk memperbesar gambar
              _showFullScreenImage(context, buktiImageUrl);
            },
            child: Image.asset(
              buktiImageUrl, // Path ke gambar bukti
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  // Fungsi untuk menampilkan gambar full screen menggunakan PhotoView
  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: PhotoView(
              imageProvider: AssetImage(imageUrl), // Menampilkan gambar secara penuh
              backgroundDecoration: const BoxDecoration(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
