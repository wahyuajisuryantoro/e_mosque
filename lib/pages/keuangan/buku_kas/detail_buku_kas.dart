import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:photo_view/photo_view.dart';

class DetailBukuKasPage extends StatelessWidget {
  final String namaBukuKas = 'Bank Mandiri';
  final String saldoAwal = '3.000.000';
  final String saldoAkhir = '3.000.000';
  final String tanggalTransaksi = '2024-09-01';
  final String keterangan = 'Pembelian Peralatan Masjid';
  final String akunTransaksi = 'Operasional';
  final String debit = '500.000';
  final String kredit = '-';
  final String saldo = '2.500.000';
  final String buktiImageUrl = 'assets/images/bukti_transaksi.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detail Buku Kas',
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
        child: Card(
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
                // Detail Buku Kas dan Saldo
                _buildDetailRow('Nama Buku Kas', namaBukuKas),
                _buildDetailRow('Saldo Awal', 'Rp $saldoAwal'),
                _buildDetailRow('Saldo Akhir', 'Rp $saldoAkhir'),

                const SizedBox(height: 16),

                // Detail Transaksi
                Text(
                  'Detail Transaksi',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDetailRow('Tanggal Transaksi', tanggalTransaksi),
                _buildDetailRow('Keterangan', keterangan),
                _buildDetailRow('Akun Transaksi', akunTransaksi),
                _buildDetailRow('Debit', 'Rp $debit'),
                _buildDetailRow('Kredit', kredit == '-' ? '-' : 'Rp $kredit'),
                _buildDetailRow('Saldo', 'Rp $saldo'),
                const SizedBox(height: 16),
                _buildBuktiTransaksi(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun baris detail transaksi dengan teks yang sejajar
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, 
        children: [
          Text(
            '$label:',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun tampilan foto bukti transaksi dengan PhotoView
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
        GestureDetector(
          onTap: () {
            _showFullScreenImage(context, buktiImageUrl);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              buktiImageUrl,
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
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: PhotoView(
              imageProvider: AssetImage(imageUrl),
              backgroundDecoration: BoxDecoration(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
