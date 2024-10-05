import 'dart:io';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/components/custom_buttom_navigation_bar.dart';
import 'package:e_mosque/controllers/auth_controller.dart';
import 'package:e_mosque/controllers/profile_controller.dart';
import 'package:e_mosque/pages/auth/update_password.dart';
import 'package:e_mosque/pages/home/home.dart';
import 'package:e_mosque/pages/profile_user/general/update_general_information.dart';
import 'package:e_mosque/pages/profile_user/bantuan/kebijakan_privasi.dart';
import 'package:e_mosque/pages/profile_user/bantuan/syarat_ketentuan.dart';
import 'package:e_mosque/pages/profile_user/tentang/donasi.dart';
import 'package:e_mosque/pages/profile_user/tentang/hubungi_kami.dart';
import 'package:e_mosque/pages/profile_user/tentang/tentang_kami.dart';
import 'package:e_mosque/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = ProfileController();
  final AuthController authController = AuthController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      final user = Provider.of<UserProvider>(context, listen: false).user;

      if (user != null) {
        bool success = await profileController.updatePhotoProfile(
          userId: user.userId.toString(),
          picture: _imageFile,
          context: context,
        );

        if (success) {
          print("Gambar profil berhasil diperbarui.");
        } else {
          print("Gagal memperbarui gambar profil.");
        }
      } else {
        print("User tidak ditemukan!");
      }
    }
  }

  void _logout() {
    authController.logout(context); 
  }



  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.deepGreenGradient,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 300, 
              decoration: BoxDecoration(
                gradient: AppColors.deepGreenGradient,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: user.picture.isNotEmpty
                          ? NetworkImage(user.picture)
                          : const AssetImage('assets/images/user1.jpg')
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: MediaQuery.of(context).size.width * 0.25,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: _pickImage,
                        color: Colors.blue,
                        iconSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  user.name,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${user.email} | ${user.phone}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),

                // Menu dalam satu Card dengan Background Putih
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background putih untuk menu
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Edit Profile Information
                        ListTile(
                          leading: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              'assets/icons/edit.svg',
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            'Edit Profile Information',
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UpdateGeneralInformation()),
                            );
                          },
                        ),
                        // Lupa Sandi
                        ListTile(
                          leading: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              'assets/icons/forget-password.svg',
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            'Lupa Sandi',
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black),
                          onTap:(){
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdatePasswordScreen()));
                          },
                        ),
                        // Tentang Kami
                        ListTile(
                          leading: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              'assets/icons/about.svg',
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            'Tentang Kami',
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TentangKamiScreen()));
                          },
                        ),
                        // Hubungi Kami
                        ListTile(
                          leading: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              'assets/icons/hubungi_kami.svg',
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            'Hubungi Kami',
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HubungiKamiScreen()));
                          },
                        ),
                        // Donasi
                        ListTile(
                          leading: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              'assets/icons/donasi.svg',
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            'Donasi',
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonasiScreen()));
                          },
                        ),
                        // Syarat dan Ketentuan
                        ListTile(
                          leading: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              'assets/icons/syarat_ketentuan.svg',
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            'Syarat dan Ketentuan',
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SyaratdanKetentuanScreen()),
                            );
                          },
                        ),
                        // Kebijakan Privasi
                        ListTile(
                          leading: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              'assets/icons/kebijakan_privasi.svg',
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            'Kebijakan dan Privasi',
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      KebijakandanPrivasiScreen()),
                            );
                          },
                        ),
                        
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Logout Button (tetap sama)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppColors.deepRedGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: _logout,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
