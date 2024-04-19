import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomBarMaterial extends StatelessWidget {

  final Color colorIcon = const Color(0xFFFFFFFF);
  final Color colorSelect = const Color(0xFF383838);
  final Color colorBackground = const Color(0xFFFFC533);
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomBarMaterial({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color colorIcon= Color(0xFFFFFFFF);
    const Color colorSelect= Color(0xFFFFC533);
    const Color colorBackground= Color(0xFF383838);

    return BottomNavigationBar(
      unselectedItemColor: colorIcon,
      selectedItemColor: colorSelect,
      onTap: onTap,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: colorBackground,
      selectedFontSize: 14,
      selectedLabelStyle: GoogleFonts.lato(
          fontWeight: FontWeight.w700
      ),
      iconSize: 26,
      showUnselectedLabels: true,
      items: [
        _bottomNavigationBarItem(
          icon: Icons.house_rounded,
          label: 'Home',
        ),
        _bottomNavigationBarItem(
          icon: Icons.explore,
          label: 'Explore',
        ),
        _bottomNavigationBarItem(
          icon: Icons.bookmark,
          label: 'Bookmark',
        ),
        _bottomNavigationBarItem(
          icon: FontAwesomeIcons.clockRotateLeft,
          label: 'History',
        ),
      ],
    );
  }
  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
