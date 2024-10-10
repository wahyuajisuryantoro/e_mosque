import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';

class LaporanTransaksiPage extends StatefulWidget {
  const LaporanTransaksiPage({super.key});

  @override
  _LaporanTransaksiPageState createState() => _LaporanTransaksiPageState();
}

class _LaporanTransaksiPageState extends State<LaporanTransaksiPage> {
  String _selectedMonth = 'September 2024'; // Default bulan yang dipilih
  final List<String> _months = [
    'Januari 2024',
    'Februari 2024',
    'Maret 2024',
    'April 2024',
    'Mei 2024',
    'Juni 2024',
    'Juli 2024',
    'Agustus 2024',
    'September 2024',
    'Oktober 2024',
    'November 2024',
    'Desember 2024',
  ];

  // Data laporan transaksi (contoh)
  final Map<String, Map<String, String>> _reportData = {
    'September 2024': {
      'Saldo Bulan Sebelumnya': '21.000.000',
      'Total Pemasukan': '0',
      'Total Pengeluaran': '0',
      'Saldo Akhir': '21.000.000',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFilterSection(),
              const SizedBox(height: 20),
              _buildLaporanCard(context, _selectedMonth),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk filter bulan dengan style dropdown lebih modern
  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pilih Bulan:',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton<String>(
            value: _selectedMonth,
            dropdownColor: Colors.white,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            style: GoogleFonts.poppins(color: Colors.black),
            underline: const SizedBox(),
            items: _months.map((String month) {
              return DropdownMenuItem<String>(
                value: month,
                child: Text(
                  month,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (String? newMonth) {
              setState(() {
                _selectedMonth = newMonth!;
              });
            },
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan laporan dengan card modern dan gradient background
  Widget _buildLaporanCard(BuildContext context, String month) {
    final data = _reportData[month];

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Balance',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Rp ${data?['Saldo Akhir'] ?? '0'}',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.white54),
            const SizedBox(height: 10),
            _buildInfoRow('Saldo Bulan Sebelumnya', data?['Saldo Bulan Sebelumnya'] ?? '0', Colors.white),
            _buildInfoRow('Total Pemasukan', data?['Total Pemasukan'] ?? '0', Colors.white),
            _buildInfoRow('Total Pengeluaran', data?['Total Pengeluaran'] ?? '0', Colors.white),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat row informasi dengan kustomisasi warna
  Widget _buildInfoRow(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: textColor,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
