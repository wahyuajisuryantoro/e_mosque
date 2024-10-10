import 'package:e_mosque/pages/inventaris/item_barang/detail_item_barang.dart';
import 'package:e_mosque/pages/inventaris/item_barang/edit_item_barang.dart';
import 'package:e_mosque/pages/inventaris/item_barang/tambah_item_barang.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';

class ItemBarangPage extends StatelessWidget {
  final List<Map<String, String>> itemBarangData = [
    {
      'no': '1',
      'code': '231231231',
      'nama': 'Sajadah',
      'kategori': 'Elektronik',
      'harga': '1.231.231',
      'status': 'baik'
    },
    {
      'no': '2',
      'code': 'S12345',
      'nama': 'Sajadah',
      'kategori': 'Elektronik',
      'harga': '30.000',
      'status': 'baik'
    },
    {
      'no': '3',
      'code': 'M12345',
      'nama': 'Speaker',
      'kategori': 'Fashion',
      'harga': '123.456',
      'status': 'rusak berat'
    },
    {
      'no': '4',
      'code': 'SP12346',
      'nama': 'Speaker Aktif',
      'kategori': 'Elektronik',
      'harga': '1.000.000',
      'status': 'rusak ringan'
    },
    {
      'no': '5',
      'code': 'SP12345',
      'nama': 'Speaker Aktif',
      'kategori': 'Elektronik',
      'harga': '1.500.000',
      'status': 'baik'
    },
  ];

  ItemBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: itemBarangData.length,
                itemBuilder: (context, index) {
                  final itemBarang = itemBarangData[index];
                  return _buildItemBarangCard(context, itemBarang);
                },
              ),
            ),
            _buildTambahButton(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildItemBarangCard(
      BuildContext context, Map<String, String> itemBarang) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailItemBarangPage()));
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemBarang['nama']!,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kategori: ${itemBarang['kategori']}',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow('Kode Barang', itemBarang['code']!),
                  _buildInfoRow('Harga', itemBarang['harga']!),
                  _buildInfoRow('Status', itemBarang['status']!),
                ],
              ),
              Positioned(
                top: 10,
                right: 0,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: AppColors.primaryGradient.colors.first,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditItemBarangPage()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan informasi barang
  Widget _buildInfoRow(String label, String value) {
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

  // Fungsi untuk menampilkan tombol tambah item barang
  Widget _buildTambahButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Navigasi ke halaman tambah item barang
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TambahItemBarangPage()));
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Tambah Item Barang',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
