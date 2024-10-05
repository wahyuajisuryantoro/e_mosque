import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart'; // Asumsi AppColors didefinisikan di sini

class DetailBarangPage extends StatefulWidget {
  final Map<String, String> barang;

  DetailBarangPage({required this.barang});

  @override
  _DetailBarangPageState createState() => _DetailBarangPageState();
}

class _DetailBarangPageState extends State<DetailBarangPage> {
  bool _isDetailVisible = false;

  final List<Map<String, String>> itemData = [
    {
      'kode': '231231231',
      'nama': 'Sajadah',
      'deskripsi': '23123',
      'harga': '1.231.231',
      'status': 'Baik',
      'tanggal': '2024-08-30 02:34:00'
    },
    {
      'kode': 'S12345',
      'nama': 'Sajadah',
      'deskripsi': '',
      'harga': '30.000',
      'status': 'Baik',
      'tanggal': '2023-06-14 15:40:11'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.barang['nama']!,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            const SizedBox(height: 16),
            _buildDetailSection(),
            const SizedBox(height: 20),
            _buildToggleButton(),
            const SizedBox(height: 10),
            if (_isDetailVisible) _buildDataItemCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Sudut melengkung
      child: Image.asset(
        'assets/images/${widget.barang['gambar']}',
        fit: BoxFit.contain, // Menjaga rasio gambar agar tidak terpotong
        width: double.infinity,
        height: 300, // Gambar lebih besar
      ),
    );
  }

  Widget _buildDetailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.barang['nama']!,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            'Rp ${widget.barang['harga']}',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Warna ini diubah oleh gradient
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.category, color: Colors.grey, size: 18),
            const SizedBox(width: 8),
            Text(
              'Kategori: ${widget.barang['kategori']}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.description, color: Colors.grey, size: 18),
            const SizedBox(width: 8),
            Text(
              'Deskripsi: Sajadah Gulung',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.straighten, color: Colors.grey, size: 18),
            const SizedBox(width: 8),
            Text(
              'Satuan: Meter',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isDetailVisible = !_isDetailVisible;
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent, // Menghilangkan bayangan
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isDetailVisible ? 'Tutup Data Item Barang' : 'Buka Data Item Barang',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              _isDetailVisible ? Icons.expand_less : Icons.expand_more,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataItemCards() {
    return Column(
      children: itemData.map((item) {
        return Card(
          color: Colors.white,
          elevation: 6,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCardRow('Kode:', item['kode']!),
                      const SizedBox(height: 5),
                      _buildCardRow('Nama:', item['nama']!),
                      const SizedBox(height: 5),
                      _buildCardRow('Deskripsi:', item['deskripsi']!),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Rp ${item['harga']}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Status: ${item['status']}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Tanggal: ${item['tanggal']}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCardRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}
