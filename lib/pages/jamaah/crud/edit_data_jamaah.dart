import 'dart:io';
import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../controllers/jamaah_controller.dart';

class EditJamaahScreen extends StatefulWidget {
  final int jamaahNo;

  const EditJamaahScreen({Key? key, required this.jamaahNo}) : super(key: key);

  @override
  _EditJamaahScreenState createState() => _EditJamaahScreenState();
}

class _EditJamaahScreenState extends State<EditJamaahScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  bool _isVersiLengkap = true;

  DateTime _selectedDate = DateTime.parse('1970-01-01');

  late TextEditingController _namaController;
  late TextEditingController _teleponController;
  late TextEditingController _nikController;
  late TextEditingController _tempatLahirController;
  late TextEditingController _kelurahanController;
  late TextEditingController _kecamatanController;
  late TextEditingController _kotaController;
  late TextEditingController _provinsiController;
  late TextEditingController _emailController;
  late TextEditingController _pekerjaanController;
  late TextEditingController _alamatController;

  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectedJamaahStatus;
  String? _selectedGolDarah;
  String? _selectedEkonomiStatus;

  final List<String> _genderOptions = ['Laki-laki', 'Perempuan'];
  final List<String> _maritalStatusOptions = [
    'Menikah',
    'Belum menikah',
    'Janda/duda'
  ];
  final List<String> _jamaahStatusOptions = ['Jamaah', 'Non-jamaah'];
  final List<String> _golDarahOptions = ['A', 'B', 'AB', 'O'];
  final List<String> _ekonomiStatusOptions = [
    'Mampu',
    'Kurang mampu',
    'Tidak mampu'
  ];

  @override
  void initState() {
    super.initState();

    _namaController = TextEditingController();
    _teleponController = TextEditingController();
    _nikController = TextEditingController();
    _tempatLahirController = TextEditingController();
    _kelurahanController = TextEditingController();
    _kecamatanController = TextEditingController();
    _kotaController = TextEditingController();
    _provinsiController = TextEditingController();
    _emailController = TextEditingController();
    _pekerjaanController = TextEditingController();
    _alamatController = TextEditingController();

    _loadJamaahData();
  }

  void _loadJamaahData() {
    final jamaahProvider = Provider.of<JamaahProvider>(context, listen: false);
    final jamaah =
        jamaahProvider.jamaahList.firstWhere((j) => j.no == widget.jamaahNo);

    _namaController.text = jamaah.name;
    _teleponController.text = jamaah.phone;
    _nikController.text = jamaah.nik != '-' ? jamaah.nik : '';
    _tempatLahirController.text =
        jamaah.birthPlace != '-' ? jamaah.birthPlace : '';
    _kelurahanController.text = jamaah.village != '-' ? jamaah.village : '';
    _kecamatanController.text =
        jamaah.subdistrict != '-' ? jamaah.subdistrict : '';
    _kotaController.text = jamaah.city != '-' ? jamaah.city : '';
    _provinsiController.text = jamaah.province != '-' ? jamaah.province : '';
    _emailController.text = jamaah.email != '-' ? jamaah.email : '';
    _pekerjaanController.text = jamaah.job != '-' ? jamaah.job : '';
    _alamatController.text = jamaah.address != '-' ? jamaah.address : '';

    _selectedGender = jamaah.sex == 'L' ? 'Laki-laki' : 'Perempuan';
    _selectedMaritalStatus =
        _normalizeDropdownValue(jamaah.marital, _maritalStatusOptions);
    _selectedJamaahStatus =
        _normalizeDropdownValue(jamaah.jamaahStatus, _jamaahStatusOptions);
    _selectedGolDarah =
        _normalizeDropdownValue(jamaah.blood.toUpperCase(), _golDarahOptions);
    _selectedEkonomiStatus =
        _normalizeDropdownValue(jamaah.economicStatus, _ekonomiStatusOptions);

    _selectedDate = jamaah.birthDate != DateTime.parse('1970-01-01')
        ? jamaah.birthDate
        : DateTime.now();
  }

  String _normalizeDropdownValue(String value, List<String> options) {
    String normalizedValue = value.trim().toLowerCase();
    for (String option in options) {
      if (option.toLowerCase() == normalizedValue) {
        return option;
      }
    }
    return options.first;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate != DateTime.parse('1970-01-01')
          ? _selectedDate
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
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

  Future<void> _showSuccessAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sukses'),
          content: const Text('Data berhasil diperbarui.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _teleponController.dispose();
    _nikController.dispose();
    _tempatLahirController.dispose();
    _kelurahanController.dispose();
    _kecamatanController.dispose();
    _kotaController.dispose();
    _provinsiController.dispose();
    _emailController.dispose();
    _pekerjaanController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jamaahProvider = Provider.of<JamaahProvider>(context, listen: true);

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
                message: 'Apakah Anda yakin ingin menghapus data ini?',
                type: AlertType.warning,
                onPressed: () async {
                  final jamaahProvider =
                      Provider.of<JamaahProvider>(context, listen: false);
                  bool success = await jamaahProvider.deleteDataJamaah(
                      no: widget.jamaahNo);
                  Navigator.pop(context); // Tutup alert
                  if (success) {
                    GlobalAlert.showAlert(
                      context: context,
                      title: 'Sukses',
                      message: 'Data berhasil dihapus',
                      type: AlertType.success,
                      onPressed: () {
                        Navigator.pop(context); // Kembali ke halaman sebelumnya
                      },
                    );
                  } else {
                    GlobalAlert.showAlert(
                      context: context,
                      title: 'Gagal',
                      message:
                          jamaahProvider.errorMessage ?? 'Gagal menghapus data',
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTextField(
                  controller: _namaController,
                  label: 'Nama',
                  validationMessage: 'Nama wajib diisi',
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _teleponController,
                  label: 'Telepon',
                  validationMessage: 'Telepon wajib diisi',
                  isRequired: true,
                ),
                const SizedBox(height: 16),
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
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child:
                      _isVersiLengkap ? _buildVersiLengkapForm() : Container(),
                ),
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
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? validationMessage,
    bool isRequired = false,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: isRequired
              ? (value) => value!.isEmpty ? validationMessage : null
              : null,
          maxLines: maxLines,
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
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _tempatLahirController,
          label: 'Tempat Lahir',
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Tanggal Lahir:',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                _selectedDate != DateTime.parse('1970-01-01')
                    ? "${_selectedDate.toLocal()}".split(' ')[0]
                    : 'Pilih Tanggal',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildDropdownField(
          'Jenis Kelamin',
          _genderOptions,
          _selectedGender,
          (value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildDropdownField(
          'Status Pernikahan',
          _maritalStatusOptions,
          _selectedMaritalStatus,
          (value) {
            setState(() {
              _selectedMaritalStatus = value;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildDropdownField(
          'Status Jamaah',
          _jamaahStatusOptions,
          _selectedJamaahStatus,
          (value) {
            setState(() {
              _selectedJamaahStatus = value;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildDropdownField(
          'Golongan Darah',
          _golDarahOptions,
          _selectedGolDarah,
          (value) {
            setState(() {
              _selectedGolDarah = value;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildDropdownField(
          'Status Ekonomi',
          _ekonomiStatusOptions,
          _selectedEkonomiStatus,
          (value) {
            setState(() {
              _selectedEkonomiStatus = value;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _pekerjaanController,
          label: 'Pekerjaan',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _alamatController,
          label: 'Alamat',
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        _buildAddressSection(),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _emailController,
          label: 'Email',
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> options,
    String? selectedValue,
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
          child: Text(option, style: GoogleFonts.poppins()),
        );
      }).toList(),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _kelurahanController,
                label: 'Kelurahan / Desa',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _kecamatanController,
                label: 'Kecamatan',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _kotaController,
                label: 'Kota / Kabupaten',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _provinsiController,
                label: 'Provinsi',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUploadPhotoButton() {
    final jamaahProvider = Provider.of<JamaahProvider>(context, listen: true);
    final jamaah =
        jamaahProvider.jamaahList.firstWhere((j) => j.no == widget.jamaahNo);

    return GestureDetector(
      onTap: _chooseFile,
      child: _image == null && (jamaah.picture == '-' || jamaah.picture.isEmpty)
          ? Container(
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
                      'Upload Foto Jamaah',
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _image != null
                      ? Image.file(
                          _image!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          'https://www.emasjid.id/amm/upload/picture/${jamaah.picture}',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: const Icon(Icons.error, color: Colors.red),
                            );
                          },
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
            ),
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
        onPressed: _updateJamaah,
        child: Text(
          'Simpan',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _updateJamaah() async {
    if (_formKey.currentState!.validate()) {
      final jamaahProvider =
          Provider.of<JamaahProvider>(context, listen: false);

      bool success = await jamaahProvider.updateDataJamaah(
        no: widget.jamaahNo,
        name: _namaController.text,
        phone: _teleponController.text,
        nik: _nikController.text.isNotEmpty ? _nikController.text : null,
        birthPlace: _tempatLahirController.text.isNotEmpty
            ? _tempatLahirController.text
            : null,
        birthDate: _selectedDate != DateTime.parse('1970-01-01')
            ? _selectedDate.toIso8601String()
            : null,
        sex: _selectedGender == 'Laki-laki' ? 'L' : 'P',
        blood: _selectedGolDarah ?? '',
        marital: _selectedMaritalStatus?.toLowerCase() ?? '',
        job: _pekerjaanController.text.isNotEmpty
            ? _pekerjaanController.text
            : null,
        economicStatus: _selectedEkonomiStatus?.toLowerCase() ?? '',
        jamaahStatus: _selectedJamaahStatus?.toLowerCase() ?? '',
        address:
            _alamatController.text.isNotEmpty ? _alamatController.text : null,
        village: _kelurahanController.text.isNotEmpty
            ? _kelurahanController.text
            : null,
        subdistrict: _kecamatanController.text.isNotEmpty
            ? _kecamatanController.text
            : null,
        city: _kotaController.text.isNotEmpty ? _kotaController.text : null,
        province: _provinsiController.text.isNotEmpty
            ? _provinsiController.text
            : null,
        email: _emailController.text.isNotEmpty ? _emailController.text : null,
        picture: _image,
      );

      if (success) {
        await _showSuccessAlert(); // Tampilkan alert sukses
      } else {
        GlobalAlert.showAlert(
          context: context,
          title: 'Gagal',
          message:
              jamaahProvider.errorMessage ?? 'Gagal memperbarui data jamaah.',
          type: AlertType.error,
        );
      }
    }
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
}
