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
  static const String imageBaseUrl = 'https://emasjid.id/amm/upload/picture/';
  final Map<String, int> jabatanPrioritas = {
    'Ketua': 1,
    'Sekretaris': 2,
    'Bendahara': 3,
  };

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
    widget.takmirList.sort((a, b) {
      int jabatanA = jabatanPrioritas[a.jabatan ?? ''] ?? 99;
      int jabatanB = jabatanPrioritas[b.jabatan ?? ''] ?? 99;

      if (jabatanA == jabatanB) {
        return a.noTakmirJabatan.compareTo(b.noTakmirJabatan);
      }

      return jabatanA.compareTo(jabatanB);
    });

    Map<String, List<Takmir>> groupedTakmir = {};
    for (var takmir in widget.takmirList) {
      String jabatan = takmir.jabatan ?? 'Jabatan tidak tersedia';
      if (!groupedTakmir.containsKey(jabatan)) {
        groupedTakmir[jabatan] = [];
      }
      groupedTakmir[jabatan]!.add(takmir);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
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
                        children: groupedTakmir.entries.map((entry) {
                          String jabatan = entry.key;
                          List<Takmir> takmirList = entry.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$jabatan:',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: takmirList.map((takmir) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: _buildTakmirRow(
                                      nama: takmir.name,
                                      imageUrl: takmir.picture ?? '', 
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTakmirRow({
    required String nama,
    required String imageUrl,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: imageUrl.isNotEmpty
              ? NetworkImage('$imageBaseUrl$imageUrl')
              : const AssetImage('assets/images/user.png') as ImageProvider,
        ),
        const SizedBox(width: 10),
        Expanded(
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
