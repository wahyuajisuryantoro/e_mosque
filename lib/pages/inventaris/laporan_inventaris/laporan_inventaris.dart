import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';

class LaporanInventarisPage extends StatefulWidget {
  @override
  _LaporanInventarisPageState createState() => _LaporanInventarisPageState();
}

class _LaporanInventarisPageState extends State<LaporanInventarisPage> {
  bool _isDetailVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildItemCard('Jumlah Item', '5', AppColors.blueGradient),
            const SizedBox(height: 10),
            _buildItemCard('Item Baik', '3', AppColors.primaryGradient),
            const SizedBox(height: 10),
            _buildItemCard('Item Rusak Ringan', '1', AppColors.yellowGradient),
            const SizedBox(height: 10),
            _buildItemCard('Item Rusak Berat', '1', AppColors.secondaryGradient),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                setState(() {
                  _isDetailVisible = !_isDetailVisible;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isDetailVisible
                        ? 'Tutup Daftar Barang'
                        : 'Buka Daftar Barang',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = AppColors.blueGradient.createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                        ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _isDetailVisible ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.blueGradient.colors.first,
                    size: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (_isDetailVisible) _buildDetailBarang(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(String title, String amount, LinearGradient gradient) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            amount,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailBarang() {
    return Column(
      children: [
        _buildDetailCard('Elektronik', 'Speaker Aktif', '2', '1', '1', '0'),
        const SizedBox(height: 10),
        _buildDetailCard('Elektronik', 'Speaker', '1', '0', '0', '1'),
        const SizedBox(height: 10),
        _buildDetailCard('Fashion', 'Sajadah', '2', '2', '0', '0'),
      ],
    );
  }

  Widget _buildDetailCard(String kategori, String namaBarang, String jumlah,
      String baik, String rusakRingan, String rusakBerat) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kategori,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildDetailRow('Nama Barang', namaBarang),
            _buildDetailRow('Jumlah', jumlah),
            _buildDetailRow('Baik', baik),
            _buildDetailRow('Rusak Ringan', rusakRingan),
            _buildDetailRow('Rusak Berat', rusakBerat),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
