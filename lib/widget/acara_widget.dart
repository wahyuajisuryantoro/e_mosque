import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/controllers/acara_controller.dart';
import 'package:e_mosque/widget/acara_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AcaraWidget extends StatelessWidget {
  const AcaraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AcaraProvider>(
      builder: (context, acaraProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.event,
                      color: Colors.black87,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Agenda Masjid",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              if (acaraProvider.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (acaraProvider.errorMessage != null)
                Center(
                  child: Text(
                    acaraProvider.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else
                SizedBox(
                  height: 260,
                  child: CarouselSlider.builder(
                    itemCount: acaraProvider.acaraList.length,
                    itemBuilder: (context, index, realIndex) {
                      final acara = acaraProvider.acaraList[index];
                      String formattedStartDate =
                          DateFormat('dd MMM yyyy, HH:mm')
                              .format(acara.dateStart);
                      String formattedEndDate = DateFormat('dd MMM yyyy, HH:mm')
                          .format(acara.dateEnd);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailAcaraPage(acara: acara),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.network(
                                  'https://emasjid.id/amm/upload/picture/${acara.image}',
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/default_event.png',
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: double.infinity,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      acara.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.black54,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            acara.location,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                          color: Colors.black54,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            '$formattedStartDate - $formattedEndDate',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                    },
                    options: CarouselOptions(
                      height: 260,
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
