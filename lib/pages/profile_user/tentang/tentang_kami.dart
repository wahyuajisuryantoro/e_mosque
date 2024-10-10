import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:google_fonts/google_fonts.dart';

class TentangKamiScreen extends StatefulWidget {
  const TentangKamiScreen({super.key});

  @override
  _TentangKamiScreenState createState() => _TentangKamiScreenState();
}

class _TentangKamiScreenState extends State<TentangKamiScreen> {
  String? tentangKamiContent;

  
  Future<void> fetchTentangKamiContent() async {
    try {
      final response = await http.get(Uri.parse('https://www.emasjid.id/about'));

      if (response.statusCode == 200) {
        
        var document = parse(response.body);

        
        var contentElements = document.querySelectorAll('div.site-wrapper-reveal h4, div.site-wrapper-reveal p');

        
        setState(() {
          tentangKamiContent = contentElements.map((element) => element.text).join("\n\n");
        });
      } else {
        setState(() {
          tentangKamiContent = "Gagal memuat halaman.";
        });
      }
    } catch (e) {
      setState(() {
        tentangKamiContent = "Terjadi kesalahan: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTentangKamiContent();
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
          'Tentang Kami',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: tentangKamiContent != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Text(
                  tentangKamiContent!,
                  style: GoogleFonts.poppins(fontSize: 16, height: 1.6),
                  textAlign: TextAlign.justify,
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
