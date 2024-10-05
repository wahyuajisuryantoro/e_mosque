import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; // Pastikan sudah mengimpor AppColors

class StatistikJamaahTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Card Laporan Inventaris dengan primaryGradient
          _buildStatCard(
            context,
            title: 'Laporan Inventaris',
            stats: [
              _buildStatRow('Total', '3'),
              _buildStatRow('Jamaah Aktif', '3'),
              _buildStatRow('Jamaah Tidak Aktif', '0'),
              _buildStatRow('Jamaah Donatur', '0'),
            ],
            gradient: AppColors.primaryGradient,
          ),
          SizedBox(height: 20),
          
          // Card Jenis Kelamin dengan blueGradient
          _buildStatCard(
            context,
            title: 'JENIS KELAMIN',
            stats: [
              _buildStatRow('Laki-laki', '3'),
              _buildStatRow('Perempuan', '0'),
            ],
            gradient: AppColors.blueGradient,
          ),
          SizedBox(height: 20),

          // Card Status Marital dengan yellowGradient
          _buildStatCard(
            context,
            title: 'STATUS MARITAL',
            stats: [
              _buildStatRow('Menikah', '1'),
              _buildStatRow('Tidak Menikah', '2'),
            ],
            gradient: AppColors.yellowGradient,
          ),
          SizedBox(height: 20),

          // Card Status Ekonomi dengan purpleGradient
          _buildStatCard(
            context,
            title: 'STATUS EKONOMI',
            stats: [
              _buildStatRow('Mampu', '1'),
              _buildStatRow('Tidak Mampu', '1'),
            ],
            gradient: AppColors.purpleGradient,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Widget untuk membuat setiap card dengan gradien
  Widget _buildStatCard(BuildContext context, {required String title, required List<Widget> stats, required LinearGradient gradient}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), 
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Warna teks tetap putih
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: stats,
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk setiap baris statistik
  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          ),
        ],
      ),
    );
  }
}
