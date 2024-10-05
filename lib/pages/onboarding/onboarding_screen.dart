import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/pages/auth/auth.dart';
import 'package:e_mosque/pages/onboarding/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                OnboardingWidget(
                  imagePath: 'assets/images/onboarding1.png',
                  title: 'Masjid sebagai Pusat Kehidupan Muslim',
                  subtitle:
                      '“Sesungguhnya yang memakmurkan masjid-masjid Allah hanyalah orang-orang yang beriman kepada Allah dan hari kemudian...” (QS. At-Taubah: 18)',
                ),
                OnboardingWidget(
                  imagePath: 'assets/images/onboarding2.png',
                  title: 'Al-Qur\'an sebagai Panduan Hidup',
                  subtitle:
                      '“Kitab (Al-Qur\'an) ini tidak ada keraguan padanya; petunjuk bagi mereka yang bertakwa.” (QS. Al-Baqarah: 2)',
                ),
                OnboardingWidget(
                  imagePath: 'assets/images/onboarding3.png',
                  title: 'Muslim dalam Era Digital',
                  subtitle:
                      '“Dan barang siapa yang menyerahkan dirinya kepada Allah, sedang dia orang yang berbuat kebaikan, maka sesungguhnya dia telah berpegang teguh kepada tali yang kokoh...” (QS. Luqman: 22)',
                ),
              ],
            ),
          ),
          Positioned(
            top: 40.0,
            right: 20.0,
            child: TextButton(
              onPressed: () {
                _pageController.jumpToPage(2);
              },
              child: Text(
                'Lewati',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenColor,
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onPressed: () {
                if (_currentPage == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Text(
                _currentPage == 2 ? 'Mulai' : 'Lanjut',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40.0,
            right: 20.0,
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: _currentPage == index ? 12.0 : 8.0,
                  height: _currentPage == index ? 12.0 : 8.0,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.black : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
