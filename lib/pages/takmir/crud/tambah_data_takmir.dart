import 'dart:io';
import 'package:e_mosque/controllers/takmir_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:path/path.dart' as path; 

class TambahTakmirScreen extends StatefulWidget {
  const TambahTakmirScreen({super.key});

  @override
  _TambahTakmirScreenState createState() => _TambahTakmirScreenState();
}

class _TambahTakmirScreenState extends State<TambahTakmirScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  int? _selectedJabatan;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final takmirProvider = Provider.of<TakmirProvider>(context, listen: false);
      takmirProvider.fetchJabatan();
    });
  }
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final takmirProvider = Provider.of<TakmirProvider>(context);

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
      body: takmirProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : takmirProvider.jabatanList.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada data jabatan tersedia.',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
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
                          DropdownButtonFormField<int>(
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
                            validator: (value) =>
                                value == null ? 'Jabatan harus dipilih' : null,
                            items: takmirProvider.jabatanList
                                .map((jabatan) {
                              int no = jabatan['no'];
                              return DropdownMenuItem<int>(
                                value: no,
                                child: Text(
                                  jabatan['name'] ?? 'Unknown',
                                  style: GoogleFonts.poppins(),
                                ),
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
                            controller: _nameController,
                            validator: (value) =>
                                value!.isEmpty ? 'Nama wajib diisi' : null,
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
                            controller: _addressController,
                            validator: (value) =>
                                value!.isEmpty ? 'Alamat wajib diisi' : null,
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
                            controller: _phoneController,
                            validator: (value) => value!.isEmpty
                                ? 'Nomor telepon wajib diisi'
                                : null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
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
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.poppins(),
                          ),
                          const SizedBox(height: 16),

                          // Upload Foto (dinamis)
                          GestureDetector(
                            onTap: _pickImage, // Function to pick image
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: _selectedImage == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.add_a_photo,
                                              color: Colors.grey, size: 40),
                                          Text(
                                            'Upload Foto Takmir',
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      )
                                    : Image.file(_selectedImage!,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

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
                  ),
                ),
    );
  }

  // Tombol Simpan
  Widget _buildSimpanButton(BuildContext context) {
    final takmirProvider =
        Provider.of<TakmirProvider>(context, listen: false);

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
          if (_formKey.currentState!.validate()) {
            // Tampilkan indikator loading
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );

            // Debugging: Tampilkan data yang akan dikirim
            print("Mengirim data:");
            print("name: ${_nameController.text}");
            print("phone: ${_phoneController.text}");
            print("email: ${_emailController.text.isNotEmpty ? _emailController.text : null}");
            print("address: ${_addressController.text}");
            print("no_takmir_jabatan: $_selectedJabatan");
            print("picture: ${_selectedImage?.path}");

            // Kirim data ke server
            bool success = await takmirProvider.postDataTakmir(
              name: _nameController.text,
              phone: _phoneController.text,
              email: _emailController.text.isNotEmpty ? _emailController.text : null,
              address: _addressController.text,
              link: null, // Tambahkan link jika diperlukan
              noTakmirJabatan: _selectedJabatan!,
              picture: _selectedImage, // Kirim gambar jika dipilih
            );

            // Sembunyikan indikator loading
            Navigator.of(context).pop();

            if (success) {
              // Tampilkan pesan sukses dan kembali
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data takmir berhasil disimpan')),
              );
              Navigator.pop(context);
            } else {
              // Tampilkan pesan error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(takmirProvider.errorMessage ?? '')),
              );
            }
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
  Widget _buildKembaliButton(BuildContext context) {
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
