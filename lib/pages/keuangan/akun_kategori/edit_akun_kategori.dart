import 'package:e_mosque/components/alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; // Import class warna sesuai kebutuhan

class EditAkunKategoriPage extends StatefulWidget {
  const EditAkunKategoriPage({Key? key}) : super(key: key);

  @override
  _EditAkunKategoriPageState createState() => _EditAkunKategoriPageState();
}

class _EditAkunKategoriPageState extends State<EditAkunKategoriPage> {
  final TextEditingController _namaController = TextEditingController(text: 'Operasional');
  final TextEditingController _kodeController = TextEditingController(text: '203');
  String _selectedPosition = 'Pengeluaran'; // Default value for position dropdown
  final TextEditingController _deskripsiController = TextEditingController();

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
          'Edit Akun Kategori',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              GlobalAlert.showAlert(
                context: context,
                title: 'Konfirmasi Hapus',
                message: 'Apakah Anda yakin ingin menghapus Akun ini?',
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
            // Nama Akun Kategori
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

            // Kode Akun Kategori
            Text(
              'Kode:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _kodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 20),

            // Dropdown Position
            Text(
              'Position:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedPosition,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: ['Pemasukan', 'Pengeluaran'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedPosition = newValue!;
                });
              },
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

            // Tombol Simpan dan Kembali
            Row(
              children: [
                Expanded(child: _buildSimpanButton()),
                const SizedBox(width: 10),
                Expanded(child: _buildKembaliButton()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Tombol Simpan
  Widget _buildSimpanButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Logika simpan data
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Perubahan disimpan!')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          elevation: 0,
        ),
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
  Widget _buildKembaliButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.secondaryGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          elevation: 0,
        ),
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
