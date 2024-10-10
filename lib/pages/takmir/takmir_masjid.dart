import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/controllers/takmir_controller.dart';
import 'package:e_mosque/controllers/masjid_controller.dart'; // Tambahkan import MasjidProvider
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/pages/takmir/data_takmir.dart';
import 'package:e_mosque/pages/takmir/jenis_jabatan_takmir.dart';
import 'package:e_mosque/pages/takmir/struktur_takmir.dart';
import 'package:provider/provider.dart';

class TakmirMasjidScreen extends StatefulWidget {
  const TakmirMasjidScreen({super.key});

  @override
  State<TakmirMasjidScreen> createState() => _TakmirMasjidScreenState();
}

class _TakmirMasjidScreenState extends State<TakmirMasjidScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Fetch data takmir and masjid once on initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TakmirProvider>(context, listen: false).fetchTakmir();
      Provider.of<MasjidProvider>(context, listen: false).fetchMasjid();
    });
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TakmirProvider, MasjidProvider>(
        builder: (context, takmirProvider, masjidProvider, child) {
      var takmirList = takmirProvider.takmirList;
      var masjidName = masjidProvider.masjidName ?? 'Nama Masjid';

      if (takmirProvider.isLoading) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (takmirProvider.errorMessage != null) {
        return Scaffold(
          body: Center(
            child: Text(
              takmirProvider.errorMessage!,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ),
        );
      }

      return Scaffold(
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
            'Manajemen Takmir',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: false,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey[300],
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
                  tabs: const [
                    Tab(text: 'Struktur Takmir'),
                    Tab(text: 'Data Takmir'),
                    Tab(text: 'Jenis Jabatan'),
                  ],
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(color: Colors.white, width: 3),
                    insets: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    StrukturTakmir(
                        takmirList: takmirList,
                        masjidName: masjidName), // Kirim nama masjid
                    DataTakmir(
                      takmirList: takmirList,
                    ),
                    const JenisJabatanTakmir(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
