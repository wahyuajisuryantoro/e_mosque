import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class DonasiScreen extends StatefulWidget {
  @override
  _DonasiScreenState createState() => _DonasiScreenState();
}

class _DonasiScreenState extends State<DonasiScreen> {
  String? haditsContent;
  String? sumberHaditsContent;
  String? donasiContent;
  List<Map<String, String>> bankRekening = [];

  Future<void> fetchDonasiContent() async {
    try {
      final response = await http.get(Uri.parse('https://www.emasjid.id/donation'));

      if (response.statusCode == 200) {
        var document = parse(response.body);
        var haditsElement = document.querySelector('div.feature-large-images-wrapper h2');
        var sumberHaditsElement = document.querySelector('div.feature-large-images-wrapper h5');
        var textElements = document.querySelectorAll('div.feature-large-images-wrapper p');

        setState(() {
          haditsContent = haditsElement?.text.trim() ?? '';
          sumberHaditsContent = sumberHaditsElement?.text.trim() ?? '';
          donasiContent = textElements.map((element) => element.text.trim()).join("\n\n");
        });

        var rekeningElements = document.querySelectorAll('div.feature-images__two .single-item');
        List<Map<String, String>> rekeningData = [];
        for (var item in rekeningElements) {
          var bankName = item.querySelector('h6.heading')?.text ?? '';
          var bankDetails = item.querySelector('p')?.text ?? '';
          var bankImage = item.querySelector('img')?.attributes['src'] ?? '';
          rekeningData.add({
            'name': bankName,
            'details': bankDetails,
            'image': bankImage,
          });
        }

        setState(() {
          bankRekening = rekeningData;
        });
      } else {
        setState(() {
          donasiContent = "Gagal memuat halaman donasi.";
        });
      }
    } catch (e) {
      setState(() {
        donasiContent = "Terjadi kesalahan: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDonasiContent();
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
          'Donasi',
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
        child: donasiContent != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: haditsContent ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(text: "\n\n"),
                          TextSpan(
                            text: sumberHaditsContent ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      donasiContent!,
                      style: GoogleFonts.poppins(fontSize: 16, height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Rekening Donasi:',
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: bankRekening.map((rekening) {
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Image.network(
                                  rekening['image']!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        rekening['name']!,
                                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        rekening['details']!,
                                        style: GoogleFonts.poppins(fontSize: 14, height: 1.4),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
