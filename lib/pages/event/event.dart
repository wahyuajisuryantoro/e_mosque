import 'package:e_mosque/controllers/acara_controller.dart';
import 'package:e_mosque/model/acara.dart';
import 'package:e_mosque/pages/home/home.dart';
import 'package:e_mosque/widget/acara_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late Future<void> _fetchData;

  @override
  void initState() {
    super.initState();
    // Memuat data acara saat inisialisasi
    _fetchData =
        Provider.of<AcaraProvider>(context, listen: false).fetchAcara();
  }

  @override
  Widget build(BuildContext context) {
    final acaraProvider = Provider.of<AcaraProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        title: Text(
          'Acara Masjid',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: acaraProvider.refreshAcara,
        child: acaraProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : acaraProvider.errorMessage != null
                ? Center(
                    child: Text(
                      acaraProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : _buildEventList(acaraProvider.acaraList),
      ),
    );
  }

  Widget _buildEventList(List<Acara> acaraList) {
    if (acaraList.isEmpty) {
      return Center(
        child: Text(
          'Belum ada acara.',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      itemCount: acaraList.length,
      itemBuilder: (context, index) {
        final acara = acaraList[index];
        return _buildEventCard(acara);
      },
    );
  }

  Widget _buildEventCard(Acara acara) {
    String formattedStartDate = DateFormat('dd MMM yyyy, HH:mm')
        .format(acara.dateStart ?? DateTime.now());

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailAcaraPage(acara: acara)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Gambar Acara
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
              child: Image.network(
                'https://emasjid.id/amm/upload/picture/${acara.image}',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/default_event.png',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            // Informasi Acara
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    acara.name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        formattedStartDate,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
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
