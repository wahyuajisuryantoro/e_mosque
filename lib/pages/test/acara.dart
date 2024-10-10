import 'package:e_mosque/model/user_model.dart';
import 'package:e_mosque/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcaraScreen extends StatelessWidget {
  final User? user; 

  const AcaraScreen({super.key, this.user}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            if (user != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else {
              
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Acara Masjid',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text('Halaman Acara'),
      ),
    );
  }
}
