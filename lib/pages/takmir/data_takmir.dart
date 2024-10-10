import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/pages/takmir/crud/edit_data_takmir.dart';
import 'package:e_mosque/pages/takmir/crud/lihat_data_takmir.dart';
import 'package:e_mosque/pages/takmir/crud/tambah_data_takmir.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/model/takmir.dart';

class DataTakmir extends StatefulWidget {
  final List<Takmir> takmirList;

  const DataTakmir({super.key, required this.takmirList});

  @override
  _DataTakmirState createState() => _DataTakmirState();
}

class _DataTakmirState extends State<DataTakmir>
    with AutomaticKeepAliveClientMixin<DataTakmir> {
  final String baseUrl = 'https://www.emasjid.id/amm/upload/picture/';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: widget.takmirList.isEmpty
                ? const Center(child: Text('Belum ada data takmir.'))
                : ListView.builder(
                    itemCount: widget.takmirList.length,
                    itemBuilder: (context, index) {
                      final takmir = widget.takmirList[index];
                      return _buildTakmirCard(
                        takmir.name,
                        takmir.phone,
                        takmir.jabatan,
                        takmir.picture,
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TambahTakmirScreen()),
                  );
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
                      'Tambah Takmir',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Widget _buildTakmirCard(
      String nama, String noHp, String jabatan, String? imageUrl) {
    String fullImageUrl = (imageUrl != null && imageUrl.isNotEmpty)
        ? '$baseUrl$imageUrl'
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: (fullImageUrl.isNotEmpty)
                            ? NetworkImage(fullImageUrl)
                            : const AssetImage('assets/images/user.png')
                                as ImageProvider,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jabatan,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              nama,
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            Text(
                              'No. HP: $noHp',
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                          builder: (context) => EditTakmirScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
