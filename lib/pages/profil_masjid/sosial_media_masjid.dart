import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:e_mosque/controllers/masjid_controller.dart';
import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/components/colors.dart';

class SosialMediaMasjidPage extends StatefulWidget {
  const SosialMediaMasjidPage({Key? key}) : super(key: key);

  @override
  _SosialMediaMasjidPageState createState() => _SosialMediaMasjidPageState();
}

class _SosialMediaMasjidPageState extends State<SosialMediaMasjidPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();
  final TextEditingController _tiktokController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final masjidProvider = Provider.of<MasjidProvider>(context);
    final masjid = masjidProvider.masjid;

    if (masjid != null) {
      _facebookController.text = masjid.facebook ?? '';
      _twitterController.text = masjid.twitter ?? '';
      _instagramController.text = masjid.instagram ?? '';
      _youtubeController.text = masjid.youtube ?? '';
      _tiktokController.text = masjid.tiktok ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); 
    final masjidProvider = Provider.of<MasjidProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Center(
            child: Text(
              'Sosial Media Masjid',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = AppColors.primaryGradient.createShader(
                    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                  ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          _buildLabelText('URL Facebook'),
          _buildTextFormField(_facebookController, 'Masukkan URL Facebook'),
          const SizedBox(height: 16),

          _buildLabelText('URL Twitter'),
          _buildTextFormField(_twitterController, 'Masukkan URL Twitter'),
          const SizedBox(height: 16),

          _buildLabelText('URL Instagram'),
          _buildTextFormField(_instagramController, 'Masukkan URL Instagram'),
          const SizedBox(height: 16),

          _buildLabelText('URL YouTube'),
          _buildTextFormField(_youtubeController, 'Masukkan URL YouTube'),
          const SizedBox(height: 16),

          _buildLabelText('URL TikTok'),
          _buildTextFormField(_tiktokController, 'Masukkan URL TikTok'),
          const SizedBox(height: 24),

          _buildSimpanButton(context, masjidProvider),
        ],
      ),
    );
  }

  Widget _buildLabelText(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String placeholder) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: 14),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle:
            GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade400),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greenColor),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSimpanButton(
      BuildContext context, MasjidProvider masjidProvider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await masjidProvider.updateSosialMediaMasjid(
            _facebookController.text.trim(),
            _twitterController.text.trim(),
            _instagramController.text.trim(),
            _youtubeController.text.trim(),
            _tiktokController.text.trim(),
          );
          if (masjidProvider.errorMessage == null) {
            GlobalAlert.showAlert(
              context: context,
              title: 'Sukses',
              message: 'Sosial media berhasil disimpan!',
              type: AlertType.success,
            );
          } else {
            GlobalAlert.showAlert(
              context: context,
              title: 'Gagal',
              message:
                  'Gagal menyimpan sosial media: ${masjidProvider.errorMessage}',
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
            padding: EdgeInsets.symmetric(vertical: 16),
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
  bool get wantKeepAlive => true; 

  @override
  void dispose() {
    _facebookController.dispose();
    _twitterController.dispose();
    _instagramController.dispose();
    _youtubeController.dispose();
    _tiktokController.dispose();
    super.dispose();
  }
}
