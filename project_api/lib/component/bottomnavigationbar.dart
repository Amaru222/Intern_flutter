import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/generated/l10n.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  const BottomBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    List<String> navIcons = [
      'assets/images/icon_bottom_bar/home_smile.png',
      'assets/images/icon_bottom_bar/calendar_event.png',
      'assets/images/icon_bottom_bar/chat_smile.png',
      'assets/images/icon_bottom_bar/settings.png'
    ];
    List<String> navIconsSelected = [
      'assets/images/icon_bottom_bar/home_smile_pick.png',
      'assets/images/icon_bottom_bar/calendar_event_pick.png',
      'assets/images/icon_bottom_bar/chat_smile_pick.png',
      'assets/images/icon_bottom_bar/settings_pick.png'
    ];
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xffffffff),
      currentIndex: currentIndex,
      unselectedItemColor: const Color(0xffa8a8b7),
      selectedItemColor: const Color(0xffc52227),
      items: [
        BottomNavigationBarItem(
            icon: Image.asset(
                currentIndex == 0 ? navIconsSelected[0] : navIcons[0]),
            label: S.of(context).home),
        BottomNavigationBarItem(
            icon: Image.asset(
                currentIndex == 1 ? navIconsSelected[1] : navIcons[1]),
            label: S.of(context).attendance),
        BottomNavigationBarItem(
            icon: Image.asset(
                currentIndex == 2 ? navIconsSelected[2] : navIcons[2]),
            label: S.of(context).message),
        BottomNavigationBarItem(
            icon: Image.asset(
                currentIndex == 3 ? navIconsSelected[3] : navIcons[3]),
            label: S.of(context).setting),
      ],
      onTap: (value) {
        final routes = ['home', 'attendance', 'message', 'setting'];
        context.go('/${routes[value]}');
      },
    );
  }
}
