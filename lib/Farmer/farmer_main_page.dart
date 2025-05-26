import 'package:app/Farmer/home_page.dart';
import 'package:app/Farmer/product/add_product_page.dart';
import 'package:app/Farmer/product/my_products_page.dart';
import 'package:app/Farmer/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FarmerMainPage extends StatefulWidget {
  const FarmerMainPage({super.key});

  @override
  State<FarmerMainPage> createState() => _FarmerMainPageState();
}

class _FarmerMainPageState extends State<FarmerMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages =  [
    FarmerHomePage(),
    FarmerAddProductPage(),
    MyProductsPage(),
    FarmerProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF74B625),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_circle),
            label: 'Farmer_J.add_product'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: 'Farmer_J.my_products'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'profile'.tr(),
          ),
        ],
      ),
    );
  }
}
