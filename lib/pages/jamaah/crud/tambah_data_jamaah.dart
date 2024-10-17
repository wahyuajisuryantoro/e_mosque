import 'dart:io';
import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/controllers/jamaah_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TambahJamaahScreen extends StatefulWidget {
  const TambahJamaahScreen({super.key});

  @override
  _TambahJamaahScreenState createState() => _TambahJamaahScreenState();
}

class _TambahJamaahScreenState extends State<TambahJamaahScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isVersiLengkap = false;
  DateTime _selectedDate = DateTime.parse('1970-01-01');
  File? _selectedImage;

  // Controllers for TextFields
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _tempatTanggalLahirController = TextEditingController();
  final TextEditingController _kelurahanController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _subdomainController = TextEditingController(text: ''); // Hidden Subdomain Controller

  // Dropdown values
  String _selectedGender = 'Laki-laki';
  String _selectedMaritalStatus = 'Menikah';
  String _selectedJamaahStatus = 'Jamaah';
  String _selectedGolDarah = 'A';
  String _selectedEconomicStatus = 'Mampu';

  // Dropdown options
  final List<String> _genderOptions = ['Laki-laki', 'Perempuan'];
  final List<String> _maritalStatusOptions = ['Menikah', 'Belum Menikah', 'Janda/Duda'];
  final List<String> _jamaahStatusOptions = ['Jamaah', 'Non-Jamaah'];
  final List<String> _golDarahOptions = ['A', 'B', 'AB', 'O'];
  final List<String> _economicStatusOptions = ['Mampu', 'Kurang Mampu', 'Tidak Mampu'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(), // Batasi hingga tanggal hari ini
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Bisa juga gunakan ImageSource.camera
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final jamaahProvider = Provider.of<JamaahProvider>(context, listen: false);

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
          'Tambah Data Jamaah',
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama (Wajib)
                    _buildTextField(
                      controller: _namaController,
                      label: 'Nama',
                      validationMessage: 'Nama wajib diisi',
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),

                    // Telepon (Wajib)
                    _buildTextField(
                      controller: _teleponController,
                      label: 'Telepon',
                      validationMessage: 'Telepon wajib diisi',
                      isRequired: true,
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
                        _isVersiLengkap ? 'Tutup Versi Lengkap' : 'Tambah Versi Lengkap',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: _isVersiLengkap ? _buildVersiLengkapForm() : Container(),
                    ),
                    const SizedBox(height: 16),

                    _buildUploadPhotoButton(),
                    const SizedBox(height: 20),

                    // Tombol Simpan dan Kembali
                    Row(
                      children: [
                        Expanded(child: _buildSimpanButton(jamaahProvider)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildKembaliButton()),
                      ],
                    ),
                    // Field subdomain tersembunyi
                    _buildHiddenSubdomainField(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? validationMessage,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: isRequired ? (value) => value!.isEmpty ? validationMessage : null : null,
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

  Widget _buildVersiLengkapForm() {
    return Column(
      children: [
        _buildTextField(
          controller: _nikController,
          label: 'NIK',
          isRequired: false,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _tempatTanggalLahirController,
          label: 'Tempat Lahir',
          isRequired: false,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Tanggal Lahir:',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                _selectedDate != DateTime.parse('1970-01-01') ? "${_selectedDate.toLocal()}".split(' ')[0] : 'Pilih Tanggal',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildDropdownField('Jenis Kelamin', _genderOptions, _selectedGender, (value) {
          setState(() {
            _selectedGender = value!;
          });
        }),
        const SizedBox(height: 16),
        _buildDropdownField('Status Pernikahan', _maritalStatusOptions, _selectedMaritalStatus, (value) {
          setState(() {
            _selectedMaritalStatus = value!;
          });
        }),
        const SizedBox(height: 16),
        _buildDropdownField('Status Jamaah', _jamaahStatusOptions, _selectedJamaahStatus, (value) {
          setState(() {
            _selectedJamaahStatus = value!;
          });
        }),
        const SizedBox(height: 16),
        _buildDropdownField('Golongan Darah', _golDarahOptions, _selectedGolDarah, (value) {
          setState(() {
            _selectedGolDarah = value!;
          });
        }),
        const SizedBox(height: 16),
        _buildDropdownField('Status Ekonomi', _economicStatusOptions, _selectedEconomicStatus, (value) {
          setState(() {
            _selectedEconomicStatus = value!;
          });
        }),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _pekerjaanController,
          label: 'Pekerjaan',
          isRequired: false,
        ),
        const SizedBox(height: 16),
        _buildAddressField(),
        const SizedBox(height: 16),
        _buildRegionField(),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _emailController,
          label: 'Email',
          isRequired: false,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> options,
    String selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      value: selectedValue,
      onChanged: onChanged,
      items: options.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        );
      }).toList(),
    );
  }

  Widget _buildAddressField() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: _kelurahanController,
            label: 'Kelurahan / Desa',
            isRequired: false,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTextField(
            controller: _kecamatanController,
            label: 'Kecamatan',
            isRequired: false,
          ),
        ),
      ],
    );
  }

  Widget _buildRegionField() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: _kotaController,
            label: 'Kota / Kabupaten',
            isRequired: false,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTextField(
            controller: _provinsiController,
            label: 'Provinsi',
            isRequired: false,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadPhotoButton() {
    return GestureDetector(
      onTap: _pickImage,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_a_photo, color: Colors.grey, size: 40),
                    Text(
                      'Upload Foto Jamaah',
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  ],
                )
              : Image.file(_selectedImage!, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildSimpanButton(JamaahProvider jamaahProvider) {
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

            // Kirim data ke server
            bool success = await jamaahProvider.postDataJamaah(
              name: _namaController.text,
              nik: _nikController.text.isNotEmpty ? _nikController.text : '-',
              birthPlace: _tempatTanggalLahirController.text.isNotEmpty ? _tempatTanggalLahirController.text : '-',
              birthDate: _selectedDate != DateTime.parse('1970-01-01') ? _selectedDate.toIso8601String() : '1970-01-01',
              sex: _selectedGender == 'Laki-laki' ? 'L' : 'P',
              blood: _selectedGolDarah,
              marital: _selectedMaritalStatus.toLowerCase(),
              job: _pekerjaanController.text.isNotEmpty ? _pekerjaanController.text : '-',
              economicStatus: _selectedEconomicStatus.toLowerCase(),
              donatur: '0',
              jamaahStatus: _selectedJamaahStatus.toLowerCase(),
              address: _kelurahanController.text.isNotEmpty ? _kelurahanController.text : '-',
              village: _kelurahanController.text.isNotEmpty ? _kelurahanController.text : '-',
              subdistrict: _kecamatanController.text.isNotEmpty ? _kecamatanController.text : '-',
              city: _kotaController.text.isNotEmpty ? _kotaController.text : '-',
              province: _provinsiController.text.isNotEmpty ? _provinsiController.text : '-',
              phone: _teleponController.text,
              email: _emailController.text.isNotEmpty ? _emailController.text : '-',
              picture: _selectedImage,
              subdomain: _subdomainController.text,
            );

            // Sembunyikan indikator loading
            Navigator.of(context).pop();

            if (success) {
              // Tampilkan pesan sukses dan kembali
              GlobalAlert.showAlert(
                context: context,
                title: 'Berhasil',
                message: 'Data jamaah berhasil disimpan',
                type: AlertType.success,
                onPressed: () {
                  Navigator.pop(context); // Kembali setelah berhasil
                },
              );
            } else {
              // Tampilkan pesan error
              GlobalAlert.showAlert(
                context: context,
                title: 'Error',
                message: jamaahProvider.errorMessage ?? 'Terjadi kesalahan saat menyimpan data',
                type: AlertType.error,
              );
            }
          }
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
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildHiddenSubdomainField() {
    return TextFormField(
      controller: _subdomainController,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      style: const TextStyle(height: 0), // Untuk menyembunyikan field secara visual
    );
  }
}
