import 'package:e_mosque/components/alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:provider/provider.dart';
import 'package:e_mosque/controllers/masjid_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

class AlamatMasjidPage extends StatefulWidget {
  const AlamatMasjidPage({super.key});

  @override
  _AlamatMasjidPageState createState() => _AlamatMasjidPageState();
}

class _AlamatMasjidPageState extends State<AlamatMasjidPage> {
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();
  final TextEditingController _mapsController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final masjidProvider =
          Provider.of<MasjidProvider>(context, listen: false);

      masjidProvider.fetchMasjid().then((_) {
        final masjid = masjidProvider.masjid;
        if (masjid != null) {
          _alamatController.text =
              masjid.address.isNotEmpty ? masjid.address : '';
          _kotaController.text = masjid.city.isNotEmpty ? masjid.city : '';
          _mapsController.text = masjid.maps.isNotEmpty ? masjid.maps : '';
          _teleponController.text =
              masjid.phone.isNotEmpty ? masjid.phone : '';
          _emailController.text = masjid.email.isNotEmpty ? masjid.email : '';
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
        padding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Center(
              child: Text(
                'Alamat Masjid',
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
            _buildLabelText('Alamat'),
            _buildTextFormField(
              _alamatController,
              hintText: 'Masukkan alamat masjid',
              prefixIcon: FontAwesomeIcons.mapMarkerAlt, 
            ),
            const SizedBox(height: 16),

            _buildLabelText('Kota/Kabupaten'),
            _buildTextFormField(
              _kotaController,
              hintText: 'Masukkan kota atau kabupaten',
              prefixIcon: FontAwesomeIcons.city, 
            ),
            const SizedBox(height: 16),

            _buildLabelText('Koordinat Peta'),
            _buildTextFormField(
              _mapsController,
              hintText: 'Masukkan koordinat peta',
              prefixIcon: FontAwesomeIcons.mapMarkedAlt, 
            ),
            const SizedBox(height: 16),

            _buildLabelText('Telepon'),
            _buildTextFormField(
              _teleponController,
              hintText: 'Masukkan nomor telepon',
              prefixIcon: FontAwesomeIcons.phone, 
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            _buildLabelText('Email'),
            _buildTextFormField(
              _emailController,
              hintText: 'Masukkan email',
              prefixIcon: FontAwesomeIcons.envelope, 
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),

            _buildSimpanButton(context, masjidProvider),
          ],
        ),
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
    TextEditingController controller, {
    String? hintText,
    IconData? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade400),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
    );
  }

  Widget _buildSimpanButton(
      BuildContext context, MasjidProvider masjidProvider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await masjidProvider.updateAlamatMasjid(
            _alamatController.text.isNotEmpty ? _alamatController.text : '',
            _kotaController.text.isNotEmpty ? _kotaController.text : '',
            _mapsController.text.isNotEmpty ? _mapsController.text : '',
            _teleponController.text.isNotEmpty
                ? _teleponController.text
                : '',
            _emailController.text.isNotEmpty ? _emailController.text : '',
          );

          if (masjidProvider.errorMessage == null) {
            GlobalAlert.showAlert(
              context: context,
              title: 'Sukses',
              message: 'Alamat berhasil disimpan!',
              type: AlertType.success,
            );
          } else {
            GlobalAlert.showAlert(
              context: context,
              title: 'Gagal',
              message:
                  'Gagal menyimpan alamat: ${masjidProvider.errorMessage}',
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
    _alamatController.dispose();
    _kotaController.dispose();
    _mapsController.dispose();
    _teleponController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
