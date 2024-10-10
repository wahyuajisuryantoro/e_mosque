import 'package:e_mosque/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/pages/profil_masjid/alamat_masjid.dart';
import 'package:e_mosque/pages/profil_masjid/data_masjid.dart';
import 'package:e_mosque/pages/profil_masjid/foto_masjid.dart';
import 'package:e_mosque/pages/profil_masjid/informasi_masjid.dart';
import 'package:e_mosque/pages/profil_masjid/sosial_media_masjid.dart';
import 'package:e_mosque/pages/profil_masjid/tentang_masjid.dart';

class ProfileMasjidWrapper extends StatefulWidget {
  const ProfileMasjidWrapper({super.key});

  @override
  _ProfileMasjidWrapperState createState() => _ProfileMasjidWrapperState();
}

class _ProfileMasjidWrapperState extends State<ProfileMasjidWrapper>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> myTabs = [
    const Tab(text: 'Informasi'),
    const Tab(text: 'Data Masjid'),
    const Tab(text: 'Tentang'),
    const Tab(text: 'Alamat Masjid'),
    const Tab(text: 'Foto'),
    const Tab(text: 'Sosial Media'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Masjid',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.greenColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: AppColors.greenColor,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              indicatorWeight: 3.0,
              labelStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              tabs: myTabs,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.white, width: 3),
                insets: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: TabBarView(
        controller: _tabController,
        children: [
          InformasiMasjidScreen(),
          const DataMasjidPage(),
          const TentangMasjidPage(),
          const AlamatMasjidPage(),
          const FotoMasjidPage(),
          const SosialMediaMasjidPage(),
        ],
      ),
    );
  }
}
