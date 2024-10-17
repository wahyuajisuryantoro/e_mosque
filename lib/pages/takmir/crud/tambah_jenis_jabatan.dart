import 'package:e_mosque/components/alert.dart'; 
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/controllers/takmir_jabatan_controller.dart'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TambahJabatanScreen extends StatefulWidget {
  const TambahJabatanScreen({super.key});

  @override
  _TambahJabatanScreenState createState() => _TambahJabatanScreenState();
}

class _TambahJabatanScreenState extends State<TambahJabatanScreen> {
  
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
          'Tambah Jabatan',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    TextFormField(
                      controller: _namaController,
                      validator: (value) =>
                          value!.isEmpty ? 'Nama Jabatan harus diisi' : null,
                      decoration: InputDecoration(
                        labelText: 'Nama Jabatan',
                        labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    
                    TextFormField(
                      controller: _levelController,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Level harus diisi' : null,
                      decoration: InputDecoration(
                        labelText: 'Level',
                        labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    
                    TextFormField(
                      controller: _deskripsiController,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi (Opsional)',
                        labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLines: 4,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    
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
          ],
        ),
      ),
    );
  }

  
  Widget _buildSimpanButton(BuildContext context) {
    final jabatanProvider =
        Provider.of<TakmirJabatanProvider>(context, listen: false);

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
            bool success = await jabatanProvider.postDataJabatanTakmir(
              name: _namaController.text,
              level: int.parse(_levelController.text),
              description: _deskripsiController.text.isNotEmpty
                  ? _deskripsiController.text
                  : null,
            );   
            // Alert hanya muncul, dan Navigator.pop akan dijalankan setelah OK ditekan
            if (success) {           
              GlobalAlert.showAlert(
                context: context,
                title: 'Sukses',
                message: 'Data jabatan berhasil disimpan.',
                type: AlertType.success,
                onPressed: () {
                  Navigator.pop(context);  // Hanya pop setelah tombol OK di klik
                },
              );
            } else {          
              GlobalAlert.showAlert(
                context: context,
                title: 'Gagal',
                message: jabatanProvider.errorMessage ?? 'Gagal menyimpan data',
                type: AlertType.error,
              );
            }
          } else {        
            GlobalAlert.showAlert(
              context: context,
              title: 'Validasi Gagal',
              message: 'Pastikan semua field yang wajib diisi telah terisi.',
              type: AlertType.warning,
            );
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
