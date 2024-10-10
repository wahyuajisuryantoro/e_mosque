import 'dart:io';
import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/controllers/takmir_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TambahTakmirScreen extends StatefulWidget {
  const TambahTakmirScreen({super.key});

  @override
  _TambahTakmirScreenState createState() => _TambahTakmirScreenState();
}

class _TambahTakmirScreenState extends State<TambahTakmirScreen> {
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noHpController = TextEditingController();
  final _emailController = TextEditingController();

  int? _selectedJabatan; // Ubah tipe menjadi int?
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Fetch data jabatan saat initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TakmirProvider>(context, listen: false).getDataJabatanTakmir();
    });
  }

  Future<void> _chooseFile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final takmirProvider = Provider.of<TakmirProvider>(context);
    final jabatanOptions = takmirProvider.jabatanList; // Dapatkan list jabatan dengan level

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
          'Tambah Data Takmir',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdown Jabatan (berisi level dan nama)
                  Text(
                    'Jabatan:',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: _selectedJabatan,
                    onChanged: (value) {
                      setState(() {
                        _selectedJabatan = value; // Simpan nilai int
                      });
                    },
                    items: jabatanOptions.map((jabatan) {
                      return DropdownMenuItem<int>(
                        value: jabatan['level'], // Gunakan level sebagai int
                        child: Text(
                          'Level ${jabatan['level']}: ${jabatan['name']}', // Tampilkan level dan nama jabatan
                          style: GoogleFonts.poppins(),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

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
                  const SizedBox(height: 16),

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
                  const SizedBox(height: 16),

                  // No. Telepon / HP
                  Text(
                    'No. Telepon / HP:',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _noHpController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                  const SizedBox(height: 16),

                  // Email (optional)
                  Text(
                    'Email (opsional):',
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
                  const SizedBox(height: 16),

                  // Upload Foto
                  _buildPhoto(),
                  const SizedBox(height: 20),

                  // Tombol Simpan dan Kembali
                  Row(
                    children: [
                      Expanded(child: _buildSimpanButton(takmirProvider)),
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

  // Widget untuk menampilkan dan mengunggah foto
  Widget _buildPhoto() {
    return _image == null
        ? GestureDetector(
            onTap: _chooseFile,
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
                    const Icon(Icons.add_a_photo, color: Colors.grey, size: 40),
                    Text(
                      'Upload Foto Takmir',
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _image!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: _deleteImage,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.secondaryGradient,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
  }

  // Tombol Simpan
  Widget _buildSimpanButton(TakmirProvider takmirProvider) {
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
        onPressed: () async {
          await _submitForm(takmirProvider); // Tunggu submit selesai
          if (takmirProvider.errorMessage == null) {
            Navigator.pop(context); // Tutup layar jika tidak ada error
          } else {
            // Tampilkan pesan kesalahan jika ada
            GlobalAlert.showAlert(
              context: context,
              title: "Gagal",
              message: takmirProvider.errorMessage!,
              type: AlertType.error,
            );
          }
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

  // Fungsi submit form
  Future<void> _submitForm(TakmirProvider takmirProvider) async {
  final email = _emailController.text.isEmpty
      ? ''
      : _emailController.text; // Set email kosong jika tidak diisi
  final picture = _image == null
      ? null
      : _image; // Set picture null jika tidak ada gambar yang diunggah

  if (_selectedJabatan != null &&
      _namaController.text.isNotEmpty &&
      _alamatController.text.isNotEmpty &&
      _noHpController.text.isNotEmpty) {
    bool success = await takmirProvider.postDataTakmir(
      name: _namaController.text,
      phone: _noHpController.text,
      email: email,
      address: _alamatController.text,
      link: '',
      noTakmirJabatan: _selectedJabatan!,
      picture: picture,
    );

    if (success) {
      GlobalAlert.showAlert(
        context: context,
        title: "Berhasil",
        message: "Data takmir berhasil ditambahkan.",
        type: AlertType.success,
        onPressed: () {
          Navigator.pop(context); // Kembali ke layar sebelumnya setelah simpan
        },
      );
    } else {
      // Tampilkan pesan kesalahan
      GlobalAlert.showAlert(
        context: context,
        title: "Kesalahan",
        message: takmirProvider.errorMessage ?? "Terjadi kesalahan.",
        type: AlertType.error,
      );
    }
  } else {
    // Tampilkan pesan error jika validasi gagal
    GlobalAlert.showAlert(
      context: context,
      title: "Kesalahan",
      message: "Semua kolom wajib diisi kecuali email dan foto.",
      type: AlertType.error,
    );
  }
}

}
