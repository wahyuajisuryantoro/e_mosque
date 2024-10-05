import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; // Pastikan AppColors tersedia untuk gradient tombol

class TambahAkunKategoriPage extends StatefulWidget {
  @override
  _TambahAkunKategoriPageState createState() => _TambahAkunKategoriPageState();
}

class _TambahAkunKategoriPageState extends State<TambahAkunKategoriPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();
  String? _selectedPosition; // Dropdown selection

  // List untuk pilihan position
  final List<String> _positionOptions = ['Pemasukan', 'Pengeluaran'];

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
          'Tambah Akun Kategori',
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
            // Nama
            _buildInputField('Nama:', _namaController),
            const SizedBox(height: 20),

            // Kode
            _buildInputField('Kode:', _kodeController),
            const SizedBox(height: 20),

            // Position Dropdown
            Text(
              'Position:',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: _selectedPosition,
              items: _positionOptions.map((position) {
                return DropdownMenuItem<String>(
                  value: position,
                  child: Text(
                    position,
                    style: GoogleFonts.poppins(),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPosition = value;
                });
              },
            ),
            const SizedBox(height: 20),
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

  // Fungsi untuk membangun input field
  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: GoogleFonts.poppins(),
        ),
      ],
    );
  }

  // Tombol Simpan
  Widget _buildSimpanButton() {
    return Container(
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
          // Logika untuk menyimpan data
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Akun Kategori berhasil disimpan!')),
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
  Widget _buildKembaliButton() {
    return Container(
      width: double.infinity,
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
