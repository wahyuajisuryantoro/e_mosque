import 'package:e_mosque/components/alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:provider/provider.dart';
import 'package:e_mosque/controllers/masjid_controller.dart';

class DataMasjidPage extends StatefulWidget {
  const DataMasjidPage({super.key});

  @override
  _DataMasjidPageState createState() => _DataMasjidPageState();
}

class _DataMasjidPageState extends State<DataMasjidPage> {
  final TextEditingController _namaMasjidController = TextEditingController();
  final TextEditingController _luasTanahController = TextEditingController();
  final TextEditingController _luasBangunanController = TextEditingController();
  final TextEditingController _statusTanahController = TextEditingController();
  final TextEditingController _tahunBerdiriController = TextEditingController();
  final TextEditingController _legalitasController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final masjidProvider = Provider.of<MasjidProvider>(context, listen: false);
      masjidProvider.fetchMasjid().then((_) {
        final masjid = masjidProvider.masjid;
        if (masjid != null) {
          setState(() {
            _namaMasjidController.text = masjid.name;
            _luasTanahController.text = masjid.luasTanah.toString();
            _luasBangunanController.text = masjid.luasBangunan.toString();
            _statusTanahController.text = masjid.statusTanah;
            _tahunBerdiriController.text = masjid.tahunBerdiri.toString();
            _legalitasController.text = masjid.legalitas;
          });
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
                'Edit Data Masjid',
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
            
            _buildLabelText('Nama Masjid'),
            _buildTextFormField(
              _namaMasjidController,
              hintText: 'Masukkan nama masjid',
              prefixIcon: Icons.account_balance,
            ),
            const SizedBox(height: 16),

            _buildLabelText('Luas Tanah (m²)'),
            _buildTextFormField(
              _luasTanahController,
              hintText: 'Masukkan luas tanah',
              prefixIcon: Icons.landscape,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            _buildLabelText('Luas Bangunan (m²)'),
            _buildTextFormField(
              _luasBangunanController,
              hintText: 'Masukkan luas bangunan',
              prefixIcon: Icons.home,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            _buildLabelText('Status Tanah'),
            _buildTextFormField(
              _statusTanahController,
              hintText: 'Masukkan status tanah',
              prefixIcon: Icons.assignment,
            ),
            const SizedBox(height: 16),

            _buildLabelText('Tahun Berdiri'),
            _buildTextFormField(
              _tahunBerdiriController,
              hintText: 'Masukkan tahun berdiri',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            _buildLabelText('Legalitas'),
            _buildTextFormField(
              _legalitasController,
              hintText: 'Masukkan legalitas',
              prefixIcon: Icons.verified_user,
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
          await masjidProvider.updateDataMasjid(
            _namaMasjidController.text,
            _luasTanahController.text,
            _luasBangunanController.text,
            _statusTanahController.text,
            _tahunBerdiriController.text,
            _legalitasController.text,
          );
          if (masjidProvider.errorMessage == null) {
            GlobalAlert.showAlert(
              context: context,
              title: 'Sukses',
              message: 'Data berhasil disimpan!',
              type: AlertType.success,
            );
          } else {
            GlobalAlert.showAlert(
              context: context,
              title: 'Gagal',
              message:
                  'Gagal menyimpan data: ${masjidProvider.errorMessage}',
              type: AlertType.error,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
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
    _namaMasjidController.dispose();
    _luasTanahController.dispose();
    _luasBangunanController.dispose();
    _statusTanahController.dispose();
    _tahunBerdiriController.dispose();
    _legalitasController.dispose();
    super.dispose();
  }
}
