import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:e_mosque/model/acara.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class DetailAcaraPage extends StatelessWidget {
  final Acara acara;

  const DetailAcaraPage({super.key, required this.acara});

  void addToCalendar() {
    final Event event = Event(
      title: acara.name,
      description: acara.description,
      location: acara.location,
      startDate: acara.dateStart,
      endDate: acara.dateEnd,
      allDay: false,
    );

    Add2Calendar.addEvent2Cal(event);
  }

  @override
  Widget build(BuildContext context) {
    String formattedStartDate = DateFormat('EEEE, dd MMMM yyyy • HH:mm', 'id_ID').format(acara.dateStart);
    String formattedEndDate = DateFormat('EEEE, dd MMMM yyyy • HH:mm', 'id_ID').format(acara.dateEnd);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [            
                Stack(
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Hero(
                        tag: 'eventImage_${acara.no}',
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          child: Image.network(
                            'https://emasjid.id/amm/upload/picture/${acara.image}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/default_event.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 14,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    acara.name,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.access_time, color: Colors.black54),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '$formattedStartDate\nhingga\n$formattedEndDate',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, color: Colors.black54),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              acara.location,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (acara.speaker != null && acara.speaker!.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.person, color: Colors.black54),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Pembicara: ${acara.speaker}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (acara.speaker != null && acara.speaker!.isNotEmpty)
                        const SizedBox(height: 16),
                      if (acara.organizer != null && acara.organizer!.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.group, color: Colors.black54),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Penyelenggara: ${acara.organizer}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (acara.organizer != null && acara.organizer!.isNotEmpty)
                        const SizedBox(height: 16),
                      
                      Text(
                        'Deskripsi Acara',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        acara.description,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            addToCalendar();
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: const Text('Tambah ke Kalender'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF42A5F5),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            textStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
