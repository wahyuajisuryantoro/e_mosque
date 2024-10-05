import 'package:e_mosque/components/colors.dart';
import 'package:e_mosque/controllers/notification_controller.dart';
import 'package:e_mosque/model/user_model.dart';
import 'package:e_mosque/pages/home/home.dart';
import 'package:e_mosque/pages/notification/notification_screen.dart';
import 'package:e_mosque/pages/profile_user/profile.dart';
import 'package:e_mosque/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    

    _pages = [
      HomeScreen(),
      NotificationScreen(),
      ProfileScreen(),
    ];
  }

  void _onTap(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 1) { 
      final notificationProvider =
          Provider.of<NotificationProvider>(context, listen: false);

      final unreadNotifications = notificationProvider.notifications
          ?.where((notif) => notif.status == 'unread')
          .toList();

      if (unreadNotifications != null && unreadNotifications.isNotEmpty) {
        for (var notif in unreadNotifications) {
          await notificationProvider.updateNotificationStatus(notif.no, 'read');
        }
      }
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => _pages[_selectedIndex],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

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
            decoration: BoxDecoration(
              gradient: AppColors.deepGreenGradient,
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: Colors.transparent,
                indicatorColor: Colors.green.shade700,
                labelTextStyle: MaterialStateProperty.all(
                  TextStyle(
                    color: Colors.white,
                  ),
                ),
                iconTheme: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return IconThemeData(color: Colors.green.shade200);
                  }
                  return IconThemeData(color: Colors.white70);
                }),
              ),
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onTap,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                destinations: [
                  // Beranda
                  NavigationDestination(
                    icon: SvgPicture.asset(
                      'assets/icons/home.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 0 ? Colors.green.shade200 : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Beranda',
                  ),
                  // Notifikasi
                  NavigationDestination(
                    icon: badges.Badge(
                      badgeContent: Text(
                        notificationProvider.notifications
                                ?.where((notif) => notif.status == 'unread')
                                .length
                                .toString() ??
                            '0',
                        style: TextStyle(color: Colors.white),
                      ),
                      showBadge: notificationProvider.notifications != null &&
                          notificationProvider.notifications!
                              .any((notif) => notif.status == 'unread'),
                      child: SvgPicture.asset(
                        'assets/icons/notif.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 1 ? Colors.green.shade200 : Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    label: 'Notifikasi',
                  ),
                  // Profil
                  NavigationDestination(
                    icon: SvgPicture.asset(
                      'assets/icons/profile.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 2 ? Colors.green.shade200 : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Profil',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
