import 'dart:io';
import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:e_mosque/controllers/takmir_controller.dart';

class EditTakmirScreen extends StatefulWidget {
  final int takmirNo;

  const EditTakmirScreen({super.key, required this.takmirNo});

  @override
  _EditTakmirScreenState createState() => _EditTakmirScreenState();
}

class _EditTakmirScreenState extends State<EditTakmirScreen> {
  late TextEditingController _namaController;
  late TextEditingController _alamatController;
  late TextEditingController _teleponController;
  late TextEditingController _emailController;
  String? _selectedJabatan = '';
  String? _currentPicture;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadTakmirData();
  }

  void _loadTakmirData() {
  final takmirProvider = Provider.of<TakmirProvider>(context, listen: false);
  final takmir =
      takmirProvider.takmirList.firstWhere((t) => t.no == widget.takmirNo);

  _namaController = TextEditingController(text: takmir.name);
  _alamatController = TextEditingController(text: takmir.address);
  _teleponController = TextEditingController(text: takmir.phone);
  _emailController = TextEditingController(text: takmir.email ?? '');
  _selectedJabatan = takmir.jabatan != null &&
          takmirProvider.jabatanList
              .any((jabatan) => jabatan['name'] == takmir.jabatan)
      ? takmir.jabatan!
      : null;

  _currentPicture = takmir.picture;
}

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _currentPicture = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final takmirProvider = Provider.of<TakmirProvider>(context, listen: true);

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
          'Edit Data Takmir',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              GlobalAlert.showConfirmation(
                context: context,
                title: 'Konfirmasi Hapus',
                message: 'Apakah Anda yakin ingin menghapus data takmir ini?',
                confirmButtonText: 'Hapus',
                cancelButtonText: 'Batal',
                onConfirm: () async {
                  final takmirProvider =
                      Provider.of<TakmirProvider>(context, listen: false);
                  bool success = await takmirProvider.deleteDataTakmir(
                    no: widget.takmirNo,
                    username: takmirProvider.takmirList
                        .firstWhere((t) => t.no == widget.takmirNo)
                        .username,
                  );
                  if (success) {
                    Navigator.pop(
                        context);
                    GlobalAlert.showAlert(
                      context: context,
                      title: 'Sukses',
                      message: 'Data takmir berhasil dihapus.',
                      type: AlertType.success,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                  } else {
                    GlobalAlert.showAlert(
                      context: context,
                      title: 'Gagal',
                      message:
                          'Gagal menghapus data takmir: ${takmirProvider.errorMessage}',
                      type: AlertType.error,
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    _selectedJabatan = value;
                  });
                },
                items: takmirProvider.jabatanList
                    .map<DropdownMenuItem<String>>((jabatan) {
                  return DropdownMenuItem<String>(
                    value: jabatan['name'] as String,
                    child: Text(jabatan['name'], style: GoogleFonts.poppins()),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              _buildPhoto(),
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
      ),
    );
  }

  Widget _buildPhoto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_currentPicture != null && _currentPicture!.isNotEmpty)
          Column(
            children: [
              Image.network(
                'https://www.emasjid.id/amm/upload/picture/$_currentPicture',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentPicture = '';
                  });
                },
                child: const Text('Hapus Gambar',
                    style: TextStyle(color: Colors.red)),
              ),
            ],
          )
        else if (_selectedImage != null)
          Image.file(_selectedImage!,
              height: 150, width: double.infinity, fit: BoxFit.cover)
        else
          GestureDetector(
            onTap: _pickImage,
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
          ),
      ],
    );
  }

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
          _updateTakmir();
        },
        child: Text(
          'Simpan',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

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

  void _updateTakmir() async {
    final takmirProvider = Provider.of<TakmirProvider>(context, listen: false);
    bool success = await takmirProvider.updateDataTakmir(
      no: widget.takmirNo,
      name: _namaController.text,
      phone: _teleponController.text,
      email: _emailController.text,
      address: _alamatController.text,
      noTakmirJabatan: takmirProvider.jabatanList
          .firstWhere((jabatan) => jabatan['name'] == _selectedJabatan)['no'],
      picture: _selectedImage,
      removePicture: _currentPicture == '',
    );

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui data takmir.')),
      );
    }
  }
}
