import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class HubungiKamiScreen extends StatefulWidget {
  @override
  _HubungiKamiScreenState createState() => _HubungiKamiScreenState();
}

class _HubungiKamiScreenState extends State<HubungiKamiScreen> {
  String? alamat;
  String? waLink;
  String? waText = "Chat Via WA";

  Future<void> fetchHubungiKamiContent() async {
    try {
      final response =
          await http.get(Uri.parse('https://www.emasjid.id/contact'));
      if (response.statusCode == 200) {
        var document = parse(response.body);
        setState(() {
          alamat = document.querySelector('address p')?.text ??
              'Alamat tidak ditemukan';
          waLink = document
                  .querySelector('a[href*="api.whatsapp.com"]')
                  ?.attributes['href'] ??
              '';
        });
      } else {
        setState(() {
          alamat = "Gagal memuat halaman.";
          waLink = "";
        });
      }
    } catch (e) {
      setState(() {
        alamat = "Terjadi kesalahan: $e";
        waLink = "";
      });
    }
  }

  void _launchWhatsApp() async {
    const String phone = '6285742595685';
    const String message =
        "Halo, saya ingin bertanya lebih lanjut terkait layanan di EMasjid. Terima kasih.";

    final String waUrl =
        "https://api.whatsapp.com/send?phone=$phone&text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(waUrl))) {
      await launchUrl(Uri.parse(waUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $waUrl';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHubungiKamiContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Hubungi Kami',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: alamat != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EMasjid.id',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Yayasan Langit Kebaikan Indonesia',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    alamat!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: _launchWhatsApp,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Chat Via WA",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
