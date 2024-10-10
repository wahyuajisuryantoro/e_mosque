import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/controllers/berita_controller.dart';
import 'package:e_mosque/widget/berita_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BeritaWidget extends StatelessWidget {
  const BeritaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan Consumer untuk memperbarui widget saat ada perubahan di BeritaProvider
    return Consumer<BeritaProvider>(
      builder: (context, beritaProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.article,
                      color: Colors.black87,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Berita Umum",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              if (beritaProvider.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (beritaProvider.errorMessage != null)
                Center(
                  child: Text(
                    beritaProvider.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else
                SizedBox(
                  height: 250, 
                  child: CarouselSlider.builder(
                    itemCount: beritaProvider.beritaList.length,
                    itemBuilder: (context, index, realIndex) {
                      final berita = beritaProvider.beritaList[index];
                      String formattedDate =
                          DateFormat('dd MMM yyyy').format(berita.date);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BeritaDetailPage(berita: berita),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0), 
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    'https://emasjid.id/amm/upload/picture/${berita.image}',
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/kajian_live.png',
                                        fit: BoxFit.cover,
                                        height: 120,
                                        width: double.infinity,
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        berita.title,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        berita.content,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            berita.author ?? 'Admin',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            formattedDate,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black54,
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
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 250, 
                      autoPlay: false, 
                      enlargeCenterPage: false, 
                      enableInfiniteScroll: true, 
                      viewportFraction: 0.9, 
                      scrollPhysics: const BouncingScrollPhysics(), 
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
