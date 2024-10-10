import 'package:e_mosque/components/alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:provider/provider.dart';
import 'package:e_mosque/controllers/masjid_controller.dart';

class TentangMasjidPage extends StatefulWidget {
  const TentangMasjidPage({super.key});

  @override
  _TentangMasjidPageState createState() => _TentangMasjidPageState();
}

class _TentangMasjidPageState extends State<TentangMasjidPage> {
  final TextEditingController _deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final masjidProvider = Provider.of<MasjidProvider>(context, listen: false);
      masjidProvider.fetchMasjid().then((_) {
        final masjid = masjidProvider.masjid;
        if (masjid != null && masjid.content.isNotEmpty) {
          _deskripsiController.text = masjid.content;
        } else {
          _deskripsiController.text = '';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final masjidProvider = Provider.of<MasjidProvider>(context);

    return GestureDetector(
      onTap: () {
        
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Center(
              child: Text(
                'Tentang Masjid',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = AppColors.primaryGradient.createShader(
                      const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                    ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Deskripsi Masjid:',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _deskripsiController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Tulis deskripsi tentang masjid...',
                hintStyle:
                    GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade400),
                contentPadding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.greenColor),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSimpanButton(masjidProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpanButton(MasjidProvider masjidProvider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_deskripsiController.text.isEmpty) {
            GlobalAlert.showAlert(
              context: context,
              title: 'Validasi Gagal',
              message: 'Deskripsi tidak boleh kosong',
              type: AlertType.warning,
            );
            return;
          }
          await masjidProvider.updateTentangMasjid(_deskripsiController.text);
          if (masjidProvider.errorMessage == null) {
            GlobalAlert.showAlert(
              context: context,
              title: 'Sukses',
              message: 'Deskripsi berhasil disimpan!',
              type: AlertType.success,
            );
          } else {
            GlobalAlert.showAlert(
              context: context,
              title: 'Gagal',
              message:
                  'Gagal menyimpan deskripsi: ${masjidProvider.errorMessage}',
              type: AlertType.error,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Simpan',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _deskripsiController.dispose();
    super.dispose();
  }
}
