import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/controllers/takmir_jabatan_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:provider/provider.dart';

class EditJabatanScreen extends StatefulWidget {
  final int jabatanNo;

  const EditJabatanScreen({super.key, required this.jabatanNo});

  @override
  _EditJabatanScreenState createState() => _EditJabatanScreenState();
}

class _EditJabatanScreenState extends State<EditJabatanScreen> {
  late TextEditingController _namaJabatanController;
  late TextEditingController _deskripsiController;
  late TextEditingController _levelController;

  @override
  void initState() {
    super.initState();
    _loadJabatanData();
  }

  void _loadJabatanData() {
    final jabatanProvider =
        Provider.of<TakmirJabatanProvider>(context, listen: false);
    final jabatan = jabatanProvider.jabatanList
        .firstWhere((j) => j.no == widget.jabatanNo);

    _namaJabatanController = TextEditingController(
        text: jabatan.name.isNotEmpty ? jabatan.name : '');
    _deskripsiController = TextEditingController(
        text: jabatan.description.isNotEmpty ? jabatan.description : '');
    _levelController = TextEditingController(
        text: jabatan.level != null ? jabatan.level.toString() : '');
  }

  @override
  Widget build(BuildContext context) {
    final jabatanProvider =
        Provider.of<TakmirJabatanProvider>(context, listen: false);

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
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              GlobalAlert.showConfirmation(
                context: context,
                title: 'Konfirmasi Hapus',
                message: 'Apakah Anda yakin ingin menghapus jabatan ini?',
                onConfirm: () async {
                  Navigator.pop(context);                 
                  bool success = await jabatanProvider.deleteJabatanTakmir(
                    no: widget.jabatanNo,
                  );
                  
                  Navigator.pop(context);

                  if (success) {
                    GlobalAlert.showAlert(
                      context: context,
                      title: 'Sukses',
                      message: 'Jabatan berhasil dihapus.',
                      type: AlertType.success,
                      onPressed: () {
                        Navigator.pop(context); 
                      },
                    );
                  } else {
                    GlobalAlert.showAlert(
                      context: context,
                      title: 'Gagal Menghapus',
                      message: jabatanProvider.errorMessage ??
                          'Gagal menghapus jabatan, mungkin masih terkait dengan data takmir.',
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
              Text(
                'Level Jabatan:',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _levelController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 16),
              Text(
                'Deskripsi Jabatan (Opsional):',
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
        onPressed: () async {
          final namaJabatan = _namaJabatanController.text.isEmpty
              ? null
              : _namaJabatanController.text;
          final level = _levelController.text.isEmpty
              ? null
              : _levelController.text;
          final deskripsi = _deskripsiController.text.isEmpty
              ? ''
              : _deskripsiController.text;

          if (namaJabatan == null || level == null) {
            GlobalAlert.showAlert(
              context: context,
              title: 'Error',
              message: 'Nama jabatan dan level harus diisi',
              type: AlertType.error,
            );
          } else {
            final jabatanProvider =
                Provider.of<TakmirJabatanProvider>(context, listen: false);
            bool success = await jabatanProvider.updateJabatanTakmir(
              no: widget.jabatanNo,
              name: namaJabatan,
              subdomain: '',
              level: int.parse(level),
              description: deskripsi,
            );
            
            Navigator.pop(context);

            if (success) {
              GlobalAlert.showAlert(
                context: context,
                title: 'Sukses',
                message: 'Data jabatan berhasil diperbarui.',
                type: AlertType.success,
                onPressed: () {
                  Navigator.pop(context); 
                  Navigator.pop(context); 
                },
              );
            } else {
              GlobalAlert.showAlert(
                context: context,
                title: 'Gagal',
                message: jabatanProvider.errorMessage ??
                    'Gagal memperbarui data jabatan.',
                type: AlertType.error,
              );
            }
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
