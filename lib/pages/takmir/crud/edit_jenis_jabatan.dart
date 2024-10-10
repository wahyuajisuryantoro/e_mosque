import 'package:e_mosque/components/alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; // Import AppColors untuk gradient

class EditJabatanScreen extends StatefulWidget {
  const EditJabatanScreen({super.key});

  @override
  _EditJabatanScreenState createState() => _EditJabatanScreenState();
}

class _EditJabatanScreenState extends State<EditJabatanScreen> {
  // Dropdown selections
  String _selectedLevel = 'Level 1';
  final List<String> _levelOptions = ['Level 1', 'Level 2', 'Level 3'];

  // Predefined values (value yang sudah ada)
  final TextEditingController _namaJabatanController =
      TextEditingController(text: 'Ketua');
  final TextEditingController _deskripsiController = TextEditingController(
      text: 'Bertanggung jawab atas seluruh kegiatan masjid.');

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
          'Edit Jabatan',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              GlobalAlert.showAlert(
                context: context,
                title: 'Konfirmasi Hapus',
                message: 'Apakah Anda yakin ingin menghapus jabatan ini?',
                type: AlertType.warning,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Jabatan
                  Text(
                    'Nama Jabatan:',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _namaJabatanController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                  const SizedBox(height: 16),

                  // Level Jabatan
                  Text(
                    'Level:',
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
                    value: _selectedLevel,
                    onChanged: (value) {
                      setState(() {
                        _selectedLevel = value!;
                      });
                    },
                    items: _levelOptions.map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(level, style: GoogleFonts.poppins()),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Deskripsi Jabatan
                  Text(
                    'Deskripsi:',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _deskripsiController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLines: 4,
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
          ],
        ),
      ),
    );
  }

  // Tombol Simpan dengan primaryGradient
  Widget _buildSimpanButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Logika simpan data
          final namaJabatan = _namaJabatanController.text;
          final level = _selectedLevel;
          final deskripsi = _deskripsiController.text;

          if (namaJabatan.isEmpty || level.isEmpty || deskripsi.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Semua field harus diisi')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data Jabatan disimpan')),
            );
            Navigator.pop(context);
          }
        },
        child: Text(
          'Simpan',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Tombol Kembali dengan secondaryGradient
  Widget _buildKembaliButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.secondaryGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Kembali',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
