import 'dart:io';

import 'package:e_mosque/components/alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditJamaahScreen extends StatefulWidget {
  const EditJamaahScreen({super.key});

  @override
  _EditJamaahScreenState createState() => _EditJamaahScreenState();
}

class _EditJamaahScreenState extends State<EditJamaahScreen> {
   File? _image;
  final picker = ImagePicker();
  bool _isVersiLengkap = true; 
  DateTime _selectedDate = DateTime(1985, 7, 20); 

  // Controllers untuk TextField
  final TextEditingController _namaController =
      TextEditingController(text: "Budi Setiawan");
  final TextEditingController _teleponController =
      TextEditingController(text: "08919191010");
  final TextEditingController _nikController =
      TextEditingController(text: "1234567890123456");
  final TextEditingController _tempatTanggalLahirController =
      TextEditingController(text: "Yogyakarta");
  final TextEditingController _kelurahanController =
      TextEditingController(text: "Ngampilan");
  final TextEditingController _kecamatanController =
      TextEditingController(text: "Danurejan");
  final TextEditingController _kotaController =
      TextEditingController(text: "Yogyakarta");
  final TextEditingController _provinsiController = TextEditingController(
      text: "Daerah Istimewa Yogyakarta");
  final TextEditingController _noTeleponController =
      TextEditingController(text: "08919191010");
  final TextEditingController _emailController =
      TextEditingController(text: "budi@email.com");

  // Dropdown Selections
  String _selectedGender = 'Laki-laki';
  String _selectedMaritalStatus = 'Menikah';
  String _selectedJamaahStatus = 'Jamaah';
  String _selectedGolDarah = 'A';
  final String _selectedEkonomiStatus = 'Mampu';

  // Dropdown Options
  final List<String> _genderOptions = ['Laki-laki', 'Perempuan'];
  final List<String> _maritalStatusOptions = [
    'Menikah',
    'Belum Menikah',
    'Janda/Duda'
  ];
  final List<String> _jamaahStatusOptions = ['Jamaah', 'Non-Jamaah'];
  final List<String> _golDarahOptions = ['A', 'B', 'AB', 'O'];
  final List<String> _ekonomiStatusOptions = ['Mampu', 'Tidak Mampu'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _chooseFile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  // Fungsi untuk menghapus gambar yang dipilih
  void _deleteImage() {
    setState(() {
      _image = null;
    });
  }

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
          'Edit Data Jamaah',
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
                message: 'Apakah Anda yakin ingin menghapus data jamaah?',
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
                  // Nama
                  Text(
                    'Nama:',
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

                  // Telepon
                  Text(
                    'Telepon:',
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
                  const SizedBox(height: 16),

                  // Tombol Versi Lengkap
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isVersiLengkap = !_isVersiLengkap;
                      });
                    },
                    child: Text(
                      _isVersiLengkap
                          ? 'Tutup Versi Lengkap'
                          : 'Tambah Versi Lengkap',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Form Versi Lengkap
                  if (_isVersiLengkap) _buildVersiLengkapForm(),
                  const SizedBox(height: 16),
                  _buildUploadPhotoButton(),
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
          ],
        ),
      ),
    );
  }

  // Form versi lengkap
  Widget _buildVersiLengkapForm() {
    return Column(
      children: [
        // NIK
        Text(
          'NIK:',
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _nikController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: GoogleFonts.poppins(),
        ),
        const SizedBox(height: 16),

        // Tempat Tanggal Lahir
        Text(
          'Tempat Tanggal Lahir:',
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _tempatTanggalLahirController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: GoogleFonts.poppins(),
        ),
        const SizedBox(height: 16),

        // Tanggal Lahir
        Row(
          children: [
            Text(
              'Tanggal Lahir:',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                "${_selectedDate.toLocal()}".split(' ')[0],
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Jenis Kelamin dan Status Pernikahan
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
                items: _genderOptions.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender, style: GoogleFonts.poppins()),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Status Pernikahan',
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: _selectedMaritalStatus,
                onChanged: (value) {
                  setState(() {
                    _selectedMaritalStatus = value!;
                  });
                },
                items: _maritalStatusOptions.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status, style: GoogleFonts.poppins()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Status Jamaah dan Golongan Darah
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Status Jamaah',
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: _selectedJamaahStatus,
                onChanged: (value) {
                  setState(() {
                    _selectedJamaahStatus = value!;
                  });
                },
                items: _jamaahStatusOptions.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status, style: GoogleFonts.poppins()),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Golongan Darah',
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: _selectedGolDarah,
                onChanged: (value) {
                  setState(() {
                    _selectedGolDarah = value!;
                  });
                },
                items: _golDarahOptions.map((gol) {
                  return DropdownMenuItem(
                    value: gol,
                    child: Text(gol, style: GoogleFonts.poppins()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Alamat
        _buildAddressSection(),

        const SizedBox(height: 16),

        // No Telepon dan Email
        Text(
          'No. Telepon / WA:',
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _noTeleponController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: GoogleFonts.poppins(),
        ),
        const SizedBox(height: 16),
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
      ],
    );
  }

  // Bagian alamat
  Widget _buildAddressSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _kelurahanController,
                decoration: InputDecoration(
                  labelText: 'Kelurahan / Desa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _kecamatanController,
                decoration: InputDecoration(
                  labelText: 'Kecamatan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _kotaController,
                decoration: InputDecoration(
                  labelText: 'Kota / Kabupaten',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _provinsiController,
                decoration: InputDecoration(
                  labelText: 'Provinsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUploadPhotoButton() {
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
                      'Upload Foto Masjid',
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
                      gradient: const LinearGradient(
                        colors: [Colors.red, Colors.redAccent],
                      ),
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

  Widget _buildSimpanButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.greenAccent],
        ),
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
        },
        child: Text(
          'Simpan',
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildKembaliButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.redAccent],
        ),
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
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
