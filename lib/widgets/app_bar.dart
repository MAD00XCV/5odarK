import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF74B625); 
    return AppBar(
      backgroundColor: primaryColor,
      title: Text(
        title.tr(), 
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      elevation: 5,
      // ignore: deprecated_member_use
      shadowColor: primaryColor.withOpacity(0.5),
    );
  }
}
