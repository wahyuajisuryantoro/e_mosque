import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/model/acara.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:share_plus/share_plus.dart';

class DetailAcaraPage extends StatelessWidget {
  final Acara acara;

  DetailAcaraPage({required this.acara});

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

  void shareEvent() {
    String message =
        'Ayo ikuti acara "${acara.name}" pada ${DateFormat('EEEE, dd MMMM yyyy • HH:mm', 'id_ID').format(acara.dateStart)} hingga ${DateFormat('EEEE, dd MMMM yyyy • HH:mm', 'id_ID').format(acara.dateEnd)} di ${acara.location}.';
    
    Share.share(message, subject: 'Undangan Acara: ${acara.name}');
  }

  @override
  Widget build(BuildContext context) {
    String formattedStartDate =
        DateFormat('EEEE, dd MMMM yyyy • HH:mm', 'id_ID').format(acara.dateStart);
    String formattedEndDate =
        DateFormat('EEEE, dd MMMM yyyy • HH:mm', 'id_ID').format(acara.dateEnd);
    return Scaffold(
      body: Stack(
        children: [      
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.deepGreenGradient,
            ),
          ),    
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [        
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: Hero(
                        tag: 'eventImage_${acara.no}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
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
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 16,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black87),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Text(
                        acara.name,
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black87,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time, color: Colors.white70),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '$formattedStartDate\nhingga\n$formattedEndDate',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, color: Colors.white70),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              acara.location,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      
                      if (acara.speaker != null && acara.speaker!.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.person, color: Colors.white70),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Pembicara: ${acara.speaker}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (acara.speaker != null && acara.speaker!.isNotEmpty)
                        SizedBox(height: 16),
                      
                      if (acara.organizer != null && acara.organizer!.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.group, color: Colors.white70),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Penyelenggara: ${acara.organizer}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (acara.organizer != null && acara.organizer!.isNotEmpty)
                        SizedBox(height: 16),
                      
                      Text(
                        'Deskripsi Acara',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        acara.description,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 24),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          
                          ElevatedButton.icon(
                            onPressed: () {
                              addToCalendar();
                            },
                            icon: Icon(Icons.calendar_today),
                            label: Text('Tambah ke Kalender'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF42A5F5), 
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              textStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                          ElevatedButton.icon(
                            onPressed: () {
                              shareEvent();
                            },
                            icon: Icon(Icons.share),
                            label: Text('Bagikan'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF9800), 
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              textStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
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
