import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_mosque/model/takmir.dart';

class StrukturTakmir extends StatefulWidget {
  final List<Takmir> takmirList;
  final String masjidName;

  const StrukturTakmir({
    Key? key,
    required this.takmirList,
    required this.masjidName,
  }) : super(key: key);

  @override
  _StrukturTakmirState createState() => _StrukturTakmirState();
}

class _StrukturTakmirState extends State<StrukturTakmir> {
  @override
  Widget build(BuildContext context) {
    if (widget.takmirList.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            'Tidak ada data takmir yang tersedia',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
      );
    }

    // Sort takmirList by noTakmirJabatan
    widget.takmirList.sort(
        (a, b) => a.noTakmirJabatan.compareTo(b.noTakmirJabatan));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Make the content scrollable
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'STRUKTUR PENGURUS\n${widget.masjidName}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: widget.takmirList.map((takmir) {
                          return Column(
                            children: [
                              _buildJabatanRow(
                                jabatan: takmir.jabatan,
                                nama: takmir.name,
                                imageUrl: takmir.picture,
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a row for each takmir member
  Widget _buildJabatanRow({
    required String jabatan,
    required String nama,
    required String imageUrl,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '$jabatan:',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CircleAvatar(
          radius: 20,
          backgroundImage: imageUrl.isNotEmpty
              ? NetworkImage(imageUrl)
              : const AssetImage('assets/images/user.png') as ImageProvider,
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Text(
            nama,
            style: GoogleFonts.poppins(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
