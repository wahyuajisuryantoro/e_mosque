import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/components/custom_buttom_navigation_bar.dart';
import 'package:e_mosque/controllers/acara_controller.dart';
import 'package:e_mosque/controllers/berita_controller.dart';
import 'package:e_mosque/controllers/notification_controller.dart';
import 'package:e_mosque/controllers/slider_controller.dart';
import 'package:e_mosque/pages/inventaris/inventaris.dart';
import 'package:e_mosque/pages/jamaah/jamaah_masjid.dart';
import 'package:e_mosque/pages/keuangan/keuangan_masjid.dart';
import 'package:e_mosque/pages/takmir/takmir_masjid.dart';
import 'package:e_mosque/pages/profil_masjid/wrapper_profile_masjid.dart';
import 'package:e_mosque/provider/user_provider.dart';
import 'package:e_mosque/widget/acara_widget.dart';
import 'package:e_mosque/widget/berita_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notificationProvider =
          Provider.of<NotificationProvider>(context, listen: false);
      notificationProvider.getNotifications();

      final sliderProvider =
          Provider.of<SliderProvider>(context, listen: false);
      sliderProvider.fetchSlider();
    });
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final sliderProvider = Provider.of<SliderProvider>(context);

    if (user == null) {
      print("User masih null");
      return const Center(child: CircularProgressIndicator());
    }

    print("User tersedia: ${user.name}");

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.deepGreenGradient,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assalamualaikum",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              user.name,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: user.picture.isNotEmpty
                  ? NetworkImage(user.picture)
                  : const AssetImage('assets/images/user.png') as ImageProvider,
              radius: 25,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshContent,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: AppColors.deepGreenGradient,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                      clipBehavior: Clip.antiAlias,
                      child: sliderProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CarouselSlider.builder(
                              itemCount: sliderProvider.sliderList.length,
                              itemBuilder: (context, index, realIndex) {
                                final sliderItem =
                                    sliderProvider.sliderList[index];
                                return Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Image.network(
                                      'https://emasjid.id/amm/upload/picture/${sliderItem.picture}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 280,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/slider_kajian.png',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 280,
                                        );
                                      },
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black54.withOpacity(0.5),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        sliderItem.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              options: CarouselOptions(
                                height: 280,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                viewportFraction: 1.0,
                                enlargeCenterPage: false,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        _buildMenuIcon(
                            'assets/icons/masjid.svg', "Profil Masjid", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileMasjidWrapper()),
                          );
                        }),
                        _buildMenuIcon('assets/icons/takmir.svg', "Takmir", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TakmirMasjidScreen()),
                          );
                        }),
                        _buildMenuIcon('assets/icons/jamaah.svg', "Jamaah", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JamaahMasjidScreen()),
                          );
                        }),
                        _buildMenuIcon(
                            'assets/icons/santri.svg', "Santri", () {}),
                        _buildMenuIcon('assets/icons/keuangan.svg', "Keuangan",
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const KeuanganMasjidScreen()),
                          );
                        }),
                        _buildMenuIcon(
                            'assets/icons/inventaris.svg', "Inventaris", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const InventarisMasjidScreen()),
                          );
                        }),
                        _buildMenuIcon(
                            'assets/icons/website.svg', "Website", () {}),
                        _buildMenuIcon(
                            'assets/icons/kajian.svg', "Kajian", () {}),
                        _buildMenuIcon(
                            'assets/icons/ziswaf.svg', "Ziswaf", () {}),
                        _buildMenuIcon(
                            'assets/icons/qurban.svg', "Qurban", () {}),
                        _buildMenuIcon('assets/icons/pustaka-digital.svg',
                            "Pustaka Digital", () {}),
                        _buildMenuIcon('assets/icons/katalog-dai.svg',
                            "Katalog Dai", () {}),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: BeritaWidget(),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: AcaraWidget(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  Future<void> _refreshContent() async {
    await Provider.of<SliderProvider>(context, listen: false).fetchSlider();
    await Provider.of<BeritaProvider>(context, listen: false).fetchBerita();
    await Provider.of<AcaraProvider>(context, listen: false).refreshAcara();
  }

  Widget _buildMenuIcon(String assetPath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: AppColors.deepGreenGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                assetPath,
                width: 30,
                height: 30,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
