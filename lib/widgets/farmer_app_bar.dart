import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FarmerBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FarmerBottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: const Color(0xFF74B625),
      unselectedItemColor: const Color(0xFF999999),
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.add_box),
          label: 'Farmer_J.add_product'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.inventory),
          label: 'Farmer_J.my_products'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: 'profile'.tr(),
        ),
      ],
    );
  }
}
