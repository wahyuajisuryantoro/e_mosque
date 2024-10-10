import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';

class LaporanSaldoPage extends StatefulWidget {
  const LaporanSaldoPage({super.key});

  @override
  _LaporanSaldoPageState createState() => _LaporanSaldoPageState();
}

class _LaporanSaldoPageState extends State<LaporanSaldoPage> {
  bool _isDetailVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSaldoCard(
                'Total Saldo', 'Rp 21.000.000', AppColors.blueGradient),
            const SizedBox(height: 10),
            _buildSaldoCard(
                'Total Pemasukan', 'Rp 7.350.000', AppColors.primaryGradient),
            const SizedBox(height: 10),
            _buildSaldoCard(
                'Total Pengeluaran', 'Rp 850.000', AppColors.secondaryGradient),
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
                        ? 'Tutup Detail Transaksi'
                        : 'Buka Detail Transaksi',
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
                    color: AppColors
                        .blueGradient.colors.first, 
                    size: 16, 
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            if (_isDetailVisible) _buildDetailTransaksi(),
          ],
        ),
      ),
    );
  }

  Widget _buildSaldoCard(String title, String amount, LinearGradient gradient) {
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

  Widget _buildDetailTransaksi() {
    return Column(
      children: [
        _buildDetailCard('Bank Mandiri', 'Saldo Awal', '3.000.000', 'Pemasukan',
            '0', 'Pengeluaran', '0', 'Saldo Akhir', '3.000.000'),
        const SizedBox(height: 10),
        _buildDetailCard('Bank BRI', 'Saldo Awal', '5.000.000', 'Pemasukan',
            '6.850.000', 'Pengeluaran', '100.000', 'Saldo Akhir', '11.750.000'),
        const SizedBox(height: 10),
        _buildDetailCard('Kas', 'Saldo Awal', '1.500.000', 'Pemasukan',
            '500.000', 'Pengeluaran', '250.000', 'Saldo Akhir', '1.750.000'),
        const SizedBox(height: 10),
        _buildDetailCard('Kas Genzi', 'Saldo Awal', '5.000.000', 'Pemasukan',
            '0', 'Pengeluaran', '500.000', 'Saldo Akhir', '4.500.000'),
      ],
    );
  }

  Widget _buildDetailCard(
      String bukuKas,
      String saldoAwalLabel,
      String saldoAwal,
      String pemasukanLabel,
      String pemasukan,
      String pengeluaranLabel,
      String pengeluaran,
      String saldoAkhirLabel,
      String saldoAkhir) {
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
              bukuKas,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildDetailRow(saldoAwalLabel, saldoAwal),
            _buildDetailRow(pemasukanLabel, pemasukan),
            _buildDetailRow(pengeluaranLabel, pengeluaran),
            _buildDetailRow(saldoAkhirLabel, saldoAkhir),
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
