import 'package:e_mosque/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TambahJamaahScreen extends StatefulWidget {
  @override
  _TambahJamaahScreenState createState() => _TambahJamaahScreenState();
}

class _TambahJamaahScreenState extends State<TambahJamaahScreen> {
  bool _isVersiLengkap = false;
  DateTime _selectedDate = DateTime.now();

  // Controllers for TextFields
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _tempatTanggalLahirController = TextEditingController();
  final TextEditingController _kelurahanController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Dropdown values
  String _selectedGender = 'Laki-laki';
  String _selectedMaritalStatus = 'Menikah';
  String _selectedJamaahStatus = 'Jamaah';
  String _selectedGolDarah = 'A';
  String _selectedEkonomiStatus = 'Mampu';

  // Dropdown options
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama
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
                  const SizedBox(height: 16),

                  // Telepon
                  Text(
                    'Telepon:',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
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

                  // Toggle Versi Lengkap
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

                  // Simpan dan Kembali Buttons
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
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
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
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
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

        // Tanggal Lahir Picker
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
                "${_selectedDate.toLocal()}".split(' ')[0],
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

        // Jenis Kelamin
        _buildDropdownField('Jenis Kelamin', _genderOptions, _selectedGender, (value) {
          setState(() {
            _selectedGender = value!;
          });
        }),
        const SizedBox(height: 16),

        // Status Pernikahan
        _buildDropdownField('Status Pernikahan', _maritalStatusOptions, _selectedMaritalStatus,
            (value) {
          setState(() {
            _selectedMaritalStatus = value!;
          });
        }),
        const SizedBox(height: 16),

        // Status Jamaah
        _buildDropdownField('Status Jamaah', _jamaahStatusOptions, _selectedJamaahStatus, (value) {
          setState(() {
            _selectedJamaahStatus = value!;
          });
        }),
        const SizedBox(height: 16),

        // Golongan Darah
        _buildDropdownField('Golongan Darah', _golDarahOptions, _selectedGolDarah, (value) {
          setState(() {
            _selectedGolDarah = value!;
          });
        }),
        const SizedBox(height: 16),

        // Kelurahan / Desa dan Kecamatan
        _buildAddressField(),
        const SizedBox(height: 16),

        // Kota / Kabupaten dan Provinsi
        _buildRegionField(),
        const SizedBox(height: 16),

        // No Telepon / WA
        Text(
          'No. Telepon / WA:',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
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

        // Email
        Text(
          'Email:',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
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
      ],
    );
  }

  // Dropdown field builder
  Widget _buildDropdownField(String label, List<String> options, String selectedValue,
      ValueChanged<String?> onChanged) {
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

  // Address field builder
  Widget _buildAddressField() {
    return Row(
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
    );
  }

  // Region field builder (Kota / Kabupaten and Provinsi)
  Widget _buildRegionField() {
    return Row(
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
    );
  }

  // Tombol untuk upload foto jamaah
  Widget _buildUploadPhotoButton() {
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
                'Upload Foto Jamaah',
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
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
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
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
