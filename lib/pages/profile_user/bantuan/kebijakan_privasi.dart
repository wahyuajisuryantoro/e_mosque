import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:google_fonts/google_fonts.dart';

class KebijakandanPrivasiScreen extends StatefulWidget {
  @override
  _KebijakandanPrivasiScreenState createState() => _KebijakandanPrivasiScreenState();
}

class _KebijakandanPrivasiScreenState extends State<KebijakandanPrivasiScreen> {
  String? privacyContent;

  
  Future<void> fetchPrivacyContent() async {
    try {
      final response = await http.get(Uri.parse('https://www.emasjid.id/privacy-protection'));

      if (response.statusCode == 200) {
        var document = parse(response.body);
        var contentElements = document.querySelectorAll('div.site-wrapper-reveal p, div.site-wrapper-reveal h5');

        setState(() {
          privacyContent = contentElements.map((element) {
            
            if (element.localName == 'h5') {
              return "##${element.text}"; 
            } else {
              return element.text;
            }
          }).join("\n\n");
        });
      } else {
        setState(() {
          privacyContent = "Gagal memuat halaman.";
        });
      }
    } catch (e) {
      setState(() {
        privacyContent = "Terjadi kesalahan: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPrivacyContent();
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
          'Kebijakan dan Privasi',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: privacyContent != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    children: _formatText(privacyContent!),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  
  List<TextSpan> _formatText(String text) {
    List<TextSpan> formattedText = [];
    List<String> paragraphs = text.split("\n\n");

    for (var paragraph in paragraphs) {
      if (paragraph.startsWith("##")) {
        
        formattedText.add(
          TextSpan(
            text: paragraph.replaceFirst("##", "") + "\n\n",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold, 
              color: Colors.black,
            ),
          ),
        );
      } else {
        
        formattedText.add(
          TextSpan(
            text: paragraph + "\n\n",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        );
      }
    }

    return formattedText;
  }
}
