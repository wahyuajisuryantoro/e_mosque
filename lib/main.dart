import 'package:e_mosque/controllers/acara_controller.dart';
import 'package:e_mosque/controllers/berita_controller.dart';
import 'package:e_mosque/controllers/notification_controller.dart';
import 'package:e_mosque/controllers/masjid_controller.dart';
import 'package:e_mosque/controllers/slider_controller.dart';
import 'package:e_mosque/controllers/takmir_controller.dart';
import 'package:e_mosque/pages/auth/auth.dart';
import 'package:e_mosque/pages/home/home.dart';
import 'package:e_mosque/pages/onboarding/onboarding_screen.dart';
import 'package:e_mosque/pages/profile_user/profile.dart';
import 'package:e_mosque/pages/profile_user/tentang/hubungi_kami.dart';
import 'package:e_mosque/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MasjidProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => BeritaProvider()),
        ChangeNotifierProvider(create: (_) => AcaraProvider()),
        ChangeNotifierProvider(create: (_) => TakmirProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingScreen(),
      ),
    );
  }
}
