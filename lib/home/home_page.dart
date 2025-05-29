import 'package:app/home/explore_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:app/profile/favourite_page.dart';
import 'package:app/cart_page.dart';
import 'package:app/profile/profile_page.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const ExplorePage(),
    const FavouritePage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    String appBarTitle;
    switch (currentIndex) {
      case 0:
        appBarTitle = 'home'.tr();
        break;
      case 1:
        appBarTitle = 'favourites'.tr();
        break;
      case 2:
        appBarTitle = 'cart'.tr();
        break;
      case 3:
        appBarTitle = 'profile'.tr();
        break;
      default:
        appBarTitle = '';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: CustomAppBar(title: appBarTitle),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.home),
            activeIcon: const Icon(IconlyBold.home),
            label: 'home'.tr(), 
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.heart),
            activeIcon: const Icon(IconlyBold.heart),
            label: 'favourites'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.buy),
            activeIcon: const Icon(IconlyBold.buy),
            label: 'cart'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.profile),
            activeIcon: const Icon(IconlyBold.profile),
            label: 'profile'.tr(),
          ),
        ],
      ),
    );
  }
}
