import 'package:e_mosque/model/jamaah.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/pages/jamaah/crud/edit_data_jamaah.dart';
import 'package:e_mosque/pages/jamaah/crud/tambah_data_jamaah.dart';

class DataJamaahTab extends StatefulWidget {
  final List<Jamaah> jamaahList;

  const DataJamaahTab({super.key, required this.jamaahList});

  @override
  _DataJamaahTabState createState() => _DataJamaahTabState();
}

class _DataJamaahTabState extends State<DataJamaahTab>
    with AutomaticKeepAliveClientMixin<DataJamaahTab> {
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
            child: widget.jamaahList.isEmpty
                ? const Center(child: Text('Belum ada data jamaah.'))
                : ListView.builder(
                    itemCount: widget.jamaahList.length,
                    itemBuilder: (context, index) {
                      final jamaah = widget.jamaahList[index];
                      return _buildJamaahCard(
                        jamaah.name,
                        jamaah.phone,
                        jamaah.marital,
                        jamaah.no,
                        jamaah.picture, // Add picture field here
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
                    MaterialPageRoute(builder: (context) => TambahJamaahScreen()),
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
                      'Tambah Jamaah',
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
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildJamaahCard(String nama, String noHp, String status, int jamaahNo, String? picture) {
    String imageUrl = (picture != null && picture.isNotEmpty)
        ? '$baseUrl$picture'
        : ''; // Full image URL or empty string

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
                        backgroundImage: (imageUrl.isNotEmpty)
                            ? NetworkImage(imageUrl)
                            : const AssetImage('assets/images/user.png') as ImageProvider, // Use local image if empty
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nama,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('No. HP: $noHp', style: GoogleFonts.poppins(fontSize: 14)),
                            const SizedBox(height: 5),
                            Text('Status: $status', style: GoogleFonts.poppins(fontSize: 14)),
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
                          builder: (context) => EditJamaahScreen(jamaahNo: jamaahNo),
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
