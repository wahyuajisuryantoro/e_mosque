import 'package:e_mosque/pages/inventaris/nama_barang/detail_barang.dart';
import 'package:e_mosque/pages/inventaris/nama_barang/tambah_barang.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';

class NamaBarangPage extends StatefulWidget {
  @override
  _NamaBarangPageState createState() => _NamaBarangPageState();
}

class _NamaBarangPageState extends State<NamaBarangPage> {
  final List<Map<String, String>> daftarBarangData = [
    {
      'no': '1',
      'nama': 'Sajadah',
      'kategori': 'Fashion',
      'harga': '100.000',
      'gambar': 'sajadah.jpg',
    },
    {
      'no': '2',
      'nama': 'Speaker',
      'kategori': 'Elektronik',
      'harga': '1.000.000',
      'gambar': 'speaker.jpg',
    },
    {
      'no': '3',
      'nama': 'Speaker Aktif',
      'kategori': 'Elektronik',
      'harga': '2.000.000',
      'gambar': 'alquran.jpeg',
    },
  ];

  List<Map<String, String>> filteredBarang = [];
  String searchQuery = '';
  String? selectedFilter = '1-5';

  @override
  void initState() {
    super.initState();
    filteredBarang = daftarBarangData; // Default to showing all items
  }

  void updateSearchResults(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredBarang = daftarBarangData
          .where((barang) =>
              barang['nama']!.toLowerCase().contains(searchQuery) ||
              barang['kategori']!.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  void updateFilter(String? newValue) {
    setState(() {
      selectedFilter = newValue;
      if (selectedFilter == '1-5') {
        filteredBarang = daftarBarangData.where((barang) {
          int number = int.parse(barang['no']!);
          return number >= 1 && number <= 5;
        }).toList();
      } else if (selectedFilter == '6-10') {
        filteredBarang = daftarBarangData.where((barang) {
          int number = int.parse(barang['no']!);
          return number >= 6 && number <= 10;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearchAndFilterBar(),
            const SizedBox(height: 10),
            Expanded(
              child: filteredBarang.isEmpty
                  ? _buildNoItemsFound() 
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.6, // Membuat card lebih panjang
                      ),
                      itemCount: filteredBarang.length,
                      itemBuilder: (context, index) {
                        final barang = filteredBarang[index];
                        return _buildBarangCard(context, barang);
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

  // Widget untuk menampilkan filter dan search bar
  Widget _buildSearchAndFilterBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Dropdown untuk filter barang
            DropdownButton<String>(
              value: selectedFilter,
              onChanged: updateFilter,
              items: const [
                DropdownMenuItem(value: '1-5', child: Text('Filter 1-5')),
                DropdownMenuItem(value: '6-10', child: Text('Filter 6-10')),
              ],
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Cari berdasarkan nama atau kategori',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                ),
                onChanged: updateSearchResults,
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildNoItemsFound() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/no_items.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              'No Items Found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarangCard(BuildContext context, Map<String, String> barang) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBarangPage(barang: barang),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/${barang['gambar']}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.primaryGradient,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        barang['no']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barang['nama']!,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    barang['kategori']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${barang['harga']}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan tombol tambah barang
  Widget _buildTambahButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Navigasi ke halaman tambah barang
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TambahBarangPage()));
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
              'Tambah Barang',
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
