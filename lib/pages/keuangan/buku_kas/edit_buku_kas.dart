import 'package:e_mosque/components/alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; // Import class warna sesuai kebutuhan

class EditBukuKasPage extends StatefulWidget {
  const EditBukuKasPage({Key? key}) : super(key: key);

  @override
  _EditBukuKasPageState createState() => _EditBukuKasPageState();
}

class _EditBukuKasPageState extends State<EditBukuKasPage> {
  final TextEditingController _namaController = TextEditingController(text: 'Bank Mandiri');
  final TextEditingController _deskripsiController = TextEditingController(text: 'Kas di rekening bank Mandiri');
  final TextEditingController _saldoAwalController = TextEditingController(text: '3.000.000');

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
          'Edit Buku Kas',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
         actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              GlobalAlert.showAlert(
                context: context,
                title: 'Konfirmasi Hapus',
                message: 'Apakah Anda yakin ingin menghapus buku kas ini?',
                type: AlertType.warning,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nama Buku Kas
            Text(
              'Nama:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _namaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 20),

            // Deskripsi Buku Kas
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

            // Saldo Awal
            Text(
              'Saldo Awal:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _saldoAwalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 20),

            // Tombol Simpan
            Container(
              width: double.infinity,
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
                  // Logika untuk menyimpan data yang telah diubah
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Perubahan disimpan!')),
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
            ),
          ],
        ),
      ),
    );
  }
}
