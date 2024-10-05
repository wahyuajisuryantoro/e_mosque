import 'package:e_mosque/components/alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; // Menggunakan AppColors yang berisi primaryGradient dan secondaryGradient

class EditTakmirScreen extends StatefulWidget {
  @override
  _EditTakmirScreenState createState() => _EditTakmirScreenState();
}

class _EditTakmirScreenState extends State<EditTakmirScreen> {
  // Dropdown selections
  String _selectedJabatan = 'Ketua';
  final List<String> _jabatanOptions = ['Ketua', 'Bendahara', 'Sekretaris'];

  // Predefined values (value yang sudah ada)
  final TextEditingController _namaController =
      TextEditingController(text: 'Fulan');
  final TextEditingController _alamatController =
      TextEditingController(text: 'Jalan ...');
  final TextEditingController _teleponController =
      TextEditingController(text: '08123456789');
  final TextEditingController _emailController =
      TextEditingController(text: 'fulan@example.com');

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
          'Edit Data Takmir',
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
              // Logika untuk menghapus data
              GlobalAlert.showAlert(
                context: context,
                title: 'Konfirmasi Hapus',
                message: 'Apakah Anda yakin ingin menghapus data takmir ini?',
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
                  // Dropdown Jabatan
                  Text(
                    'Jabatan:',
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
                    value: _selectedJabatan,
                    onChanged: (value) {
                      setState(() {
                        _selectedJabatan = value!;
                      });
                    },
                    items: _jabatanOptions.map((jabatan) {
                      return DropdownMenuItem(
                        value: jabatan,
                        child: Text(jabatan, style: GoogleFonts.poppins()),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),

                  // Nama Lengkap
                  Text(
                    'Nama Lengkap:',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
                  SizedBox(height: 16),

                  // Alamat
                  Text(
                    'Alamat:',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _alamatController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                  SizedBox(height: 16),

                  // No. Telepon / HP
                  Text(
                    'No. Telepon / HP:',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _teleponController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                  SizedBox(height: 16),

                  // Email
                  Text(
                    'Email:',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                  SizedBox(height: 16),

                  // Upload Foto
                  _buildPhoto(),
                  SizedBox(height: 20),

                  // Tombol Simpan dan Kembali
                  Row(
                    children: [
                      Expanded(child: _buildSimpanButton()),
                      SizedBox(width: 10),
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

  // Fungsi untuk mengunggah dan menghapus foto
  Widget _buildPhoto() {
    // Placeholder untuk image jika ada implementasi image picker
    return GestureDetector(
      onTap: () {
        // Logika upload foto
      },
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo, color: Colors.grey, size: 40),
              Text(
                'Upload Foto Takmir',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ],
          ),
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
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Logika simpan data
        },
        child: Text(
          'Simpan',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
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
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 15),
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
