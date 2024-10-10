import 'package:e_mosque/pages/event/event.dart';
import 'package:e_mosque/pages/home/home.dart';
import 'package:e_mosque/pages/notification/notification_screen.dart';
import 'package:e_mosque/pages/profile_user/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/controllers/notification_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      const HomeScreen(),
      const NotificationScreen(),
      const EventScreen(),
      const ProfileScreen(),
    ];
  }

  void _onTap(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
      await notificationProvider.markAllAsRead();
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => _pages[_selectedIndex],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.deepGreenGradient,
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: Colors.transparent,
                indicatorColor: Colors.green.shade700,
                labelTextStyle: WidgetStateProperty.all(
                  const TextStyle(
                    color: Colors.white,
                  ),
                ),
                iconTheme: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return IconThemeData(color: Colors.green.shade200);
                  }
                  return const IconThemeData(color: Colors.white70);
                }),
              ),
              child: Consumer<NotificationProvider>(
                builder: (context, notificationProvider, child) {
                  int unreadCount = notificationProvider.notifications
                          ?.where((notif) => notif.status == 'unread')
                          .length ??
                      0;

                  return NavigationBar(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _onTap,
                    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                    destinations: [
                      NavigationDestination(
                        icon: SvgPicture.asset(
                          'assets/icons/beranda.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            _selectedIndex == 0
                                ? Colors.green.shade200
                                : Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Beranda',
                      ),
                      NavigationDestination(
                        icon: badges.Badge(
                          badgeContent: Text(
                            unreadCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          showBadge: unreadCount > 0,
                          child: SvgPicture.asset(
                            'assets/icons/notifikasi.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              _selectedIndex == 1
                                  ? Colors.green.shade200
                                  : Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        label: 'Notifikasi',
                      ),
                      NavigationDestination(
                        icon: SvgPicture.asset(
                          'assets/icons/event.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            _selectedIndex == 2
                                ? Colors.green.shade200
                                : Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Event',
                      ),
                      NavigationDestination(
                        icon: SvgPicture.asset(
                          'assets/icons/profile_2.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            _selectedIndex == 3
                                ? Colors.green.shade200
                                : Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Profil',
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
