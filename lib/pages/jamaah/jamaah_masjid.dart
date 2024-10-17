import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/controllers/jamaah_controller.dart';
import 'package:e_mosque/pages/jamaah/data_jamaah.dart';
import 'package:e_mosque/pages/jamaah/statistik_jamaah.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JamaahMasjidScreen extends StatefulWidget {
  const JamaahMasjidScreen({super.key});

  @override
  _JamaahMasjidScreenState createState() => _JamaahMasjidScreenState();
}

class _JamaahMasjidScreenState extends State<JamaahMasjidScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JamaahProvider>(context, listen: false).fetchJamaah();
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
    return Consumer<JamaahProvider>(
      builder: (context, jamaahProvider, child) {
        var jamaahList = jamaahProvider.jamaahList;

        if (jamaahProvider.isLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (jamaahProvider.errorMessage != null) {
          return Scaffold(
            body: Center(
              child: Text(
                jamaahProvider.errorMessage!,
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
              'Manajemen Jamaah',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: false,
          ),
          backgroundColor: Colors.grey[100],
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
                      Tab(text: 'Statistik Jamaah'),
                      Tab(text: 'Data Jamaah'),
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
                      StatistikJamaahTab(),
                      DataJamaahTab(jamaahList: jamaahList),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
