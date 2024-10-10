import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/pages/inventaris/item_barang/item_barang.dart';
import 'package:e_mosque/pages/inventaris/kategori_barang/kategori_barang.dart';
import 'package:e_mosque/pages/inventaris/laporan_inventaris/laporan_inventaris.dart';
import 'package:e_mosque/pages/inventaris/nama_barang/nama_barang.dart';
import 'package:e_mosque/pages/keuangan/akun_kategori/akun_kategori.dart';
import 'package:e_mosque/pages/keuangan/buku_kas/buku_kas.dart';
import 'package:e_mosque/pages/keuangan/laporan_saldo.dart';
import 'package:e_mosque/pages/keuangan/laporan_transaksi.dart';
import 'package:e_mosque/pages/keuangan/pindah_buku.dart';
import 'package:e_mosque/pages/keuangan/tambah_pemasukan.dart';
import 'package:e_mosque/pages/keuangan/tambah_pengeluaran.dart';
import 'package:e_mosque/pages/keuangan/transaksi/transaksi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventarisMasjidScreen extends StatefulWidget {
  const InventarisMasjidScreen({super.key});

  @override
  State<InventarisMasjidScreen> createState() => _InventarisMasjidScreenState();
}

class _InventarisMasjidScreenState extends State<InventarisMasjidScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); 
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black), 
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Manajemen Inventaris',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false, 
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient, 
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[300],
                indicatorColor: Colors.white,
                indicatorWeight: 3.0,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                tabs: const [
                  Tab(text: 'Laporan Inventaris'),
                  Tab(text: 'Item Barang'),
                  Tab(text: 'Nama Barang'),
                  Tab(text: 'Kategori Barang'),
                ],
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.white, width: 3),
                  insets: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  LaporanInventarisPage(),
                  ItemBarangPage(),
                  NamaBarangPage(),
                  KategoriBarangPage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}