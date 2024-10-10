import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/controllers/masjid_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:e_mosque/model/masjid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InformasiMasjidScreen extends StatefulWidget {
  const InformasiMasjidScreen({super.key});

  @override
  _InformasiMasjidScreenState createState() => _InformasiMasjidScreenState();
}

class _InformasiMasjidScreenState extends State<InformasiMasjidScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final masjidProvider =
          Provider.of<MasjidProvider>(context, listen: false);
      masjidProvider.fetchMasjid();
    });
  }

  @override
  Widget build(BuildContext context) {
    final masjidProvider = Provider.of<MasjidProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Consumer<MasjidProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          } else if (provider.masjid != null) {
            final masjid = provider.masjid!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(masjid),
                  const SizedBox(height: 20),
                  _buildMasjidDataCard(masjid),
                  const SizedBox(height: 20),
                  _buildAlamatMasjidCard(masjid),
                  const SizedBox(height: 20),
                  _buildSosialMediaCard(masjid),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Tidak ada data masjid.'));
          }
        },
      ),
    );
  }

  Widget _buildHeader(Masjid masjid) {
    return Stack(
      children: [
        Container(
          height: 220,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage:
                    masjid.picture != null && masjid.picture!.isNotEmpty
                        ? NetworkImage(masjid.picture!)
                        : null,
                child: masjid.picture == null || masjid.picture!.isEmpty
                    ? const Icon(Icons.account_balance, size: 60, color: Colors.grey)
                    : null,
              ),
              const SizedBox(height: 10),
              Text(
                masjid.name ?? 'Nama Masjid',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMasjidDataCard(Masjid masjid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              Text(
                'Informasi Umum',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenColor,
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoRow(
                  Icons.landscape, 'Luas Tanah', '${masjid.luasTanah} m²'),
              const Divider(),
              _buildInfoRow(
                  Icons.home, 'Luas Bangunan', '${masjid.luasBangunan} m²'),
              const Divider(),
              _buildInfoRow(
                  Icons.place, 'Status Tanah', masjid.statusTanah ?? ''),
              const Divider(),
              _buildInfoRow(Icons.calendar_today, 'Tahun Berdiri',
                  '${masjid.tahunBerdiri}'),
              const Divider(),
              _buildInfoRow(
                  Icons.assignment, 'Legalitas', masjid.legalitas ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlamatMasjidCard(Masjid masjid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              Text(
                'Alamat Masjid',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueGradient.colors.first,
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoRow(Icons.location_on, 'Alamat', masjid.address ?? ''),
              const Divider(),
              _buildInfoRow(
                  Icons.location_city, 'Kota / Kabupaten', masjid.city ?? ''),
              const Divider(),
              _buildInfoRow(Icons.phone, 'Telepon', masjid.phone ?? ''),
              const Divider(),
              _buildInfoRow(Icons.email, 'Email', masjid.email ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSosialMediaCard(Masjid masjid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              Text(
                'Sosial Media',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.purpleGradient.colors.first,
                ),
              ),
              const SizedBox(height: 20),
              _buildSocialMediaRow(FontAwesomeIcons.facebook, 'Facebook',
                  masjid.facebook ?? 'Tidak tersedia'),
              const Divider(),
              _buildSocialMediaRow(FontAwesomeIcons.twitter, 'Twitter',
                  masjid.twitter ?? 'Tidak tersedia'),
              const Divider(),
              _buildSocialMediaRow(FontAwesomeIcons.instagram, 'Instagram',
                  masjid.instagram ?? 'Tidak tersedia'),
              const Divider(),
              _buildSocialMediaRow(FontAwesomeIcons.youtube, 'YouTube',
                  masjid.youtube ?? 'Tidak tersedia'),
              const Divider(),
              _buildSocialMediaRow(FontAwesomeIcons.tiktok, 'TikTok',
                  masjid.tiktok ?? 'Tidak tersedia'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.greenColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaRow(IconData icon, String label, String value) {
    return InkWell(
      onTap: () {
        
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.purpleGradient.colors.first,
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
