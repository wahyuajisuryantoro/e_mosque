import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';

class EditTransaksiPage extends StatefulWidget {
  @override
  _EditTransaksiPageState createState() => _EditTransaksiPageState();
}

class _EditTransaksiPageState extends State<EditTransaksiPage> {
  final TextEditingController _tanggalController =
      TextEditingController(text: '2024-08-31');
  final TextEditingController _nilaiTransaksiController =
      TextEditingController(text: '5000000');
  final TextEditingController _akunTransaksiController =
      TextEditingController(text: 'pemasukan - Pemasukan Jumat');
  final TextEditingController _bukuKasController =
      TextEditingController(text: 'Bank BRI');
  final TextEditingController _deskripsiController =
      TextEditingController(text: 'Donasi Pak Mamsur');

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
          'Edit Transaksi',
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
            // Tanggal Transaksi
            Text(
              'Tanggal Transaksi:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _tanggalController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 20),

            // Nilai Transaksi
            Text(
              'Nilai Transaksi:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nilaiTransaksiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 20),

            // Akun Transaksi
            Text(
              'Akun Transaksi:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _akunTransaksiController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 20),

            // Buku Kas
            Text(
              'Buku Kas:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _bukuKasController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 20),

            // Deskripsi
            Text(
              'Deskripsi:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _deskripsiController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 20),

            // Foto / Bukti Transaksi
            Text(
              'Foto / Bukti Transaksi:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildBuktiTransaksi(),

            const SizedBox(height: 30),

            // Tombol Simpan dan Kembali
            Row(
              children: [
                Expanded(child: _buildSimpanButton(context)),
                const SizedBox(width: 10),
                Expanded(child: _buildKembaliButton(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan foto bukti transaksi
  Widget _buildBuktiTransaksi() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        'assets/images/bukti_transaksi.png',
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  // Tombol Simpan
  Widget _buildSimpanButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          elevation: 0,
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Transaksi berhasil disimpan!')),
          );
        },
        child: Text(
          'Simpan',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Tombol Kembali
  Widget _buildKembaliButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.secondaryGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          elevation: 0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Kembali',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
