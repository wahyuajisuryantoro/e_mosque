import 'dart:io';
import 'package:e_mosque/components/alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/controllers/masjid_controller.dart';

class FotoMasjidPage extends StatefulWidget {
  const FotoMasjidPage({Key? key}) : super(key: key);

  @override
  _FotoMasjidPageState createState() => _FotoMasjidPageState();
}

class _FotoMasjidPageState extends State<FotoMasjidPage> {
  File? _image;
  String? _serverImageFileName;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final masjidProvider =
          Provider.of<MasjidProvider>(context, listen: false);

      
      masjidProvider.fetchMasjid().then((_) {
        final masjid = masjidProvider.masjid;

        if (masjid != null &&
            masjid.picture != null &&
            masjid.picture!.isNotEmpty) {
          setState(() {
            
            _serverImageFileName = masjid.picture;
          });
        }
      });
    });
  }

  Future<void> _chooseFile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveImage(MasjidProvider masjidProvider) async {
    if (_image == null) {
      GlobalAlert.showAlert(
        context: context,
        title: 'Error',
        message: 'Pilih foto terlebih dahulu',
        type: AlertType.warning,
      );
      return;
    }

    await masjidProvider.updateFotoMasjid(_image!);

    if (masjidProvider.errorMessage == null) {
      
      await masjidProvider.fetchMasjid();
      setState(() {
        _image = null;
        _serverImageFileName = masjidProvider.masjid?.picture;
      });

      GlobalAlert.showAlert(
        context: context,
        title: 'Sukses',
        message: 'Foto berhasil disimpan!',
        type: AlertType.success,
      );
    } else {
      GlobalAlert.showAlert(
        context: context,
        title: 'Gagal',
        message: 'Gagal menyimpan foto: ${masjidProvider.errorMessage}',
        type: AlertType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final masjidProvider = Provider.of<MasjidProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unggah Foto Masjid:',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          
          _buildImageDisplay(),

          const SizedBox(height: 20),
          _buildSimpanButton(context, masjidProvider),
        ],
      ),
    );
  }

  Widget _buildImageDisplay() {
    if (_image == null && _serverImageFileName != null) {
      
      return GestureDetector(
        onTap: _chooseFile,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                _serverImageFileName!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white70,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (_image != null) {
      
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          _image!,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    } else {
      
      return GestureDetector(
        onTap: _chooseFile,
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
                  'Upload Foto Masjid',
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildSimpanButton(
      BuildContext context, MasjidProvider masjidProvider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => _saveImage(masjidProvider),
        child: Ink(
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Simpan',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
