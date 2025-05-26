import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FarmerHomePage extends StatelessWidget {
  const FarmerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'home'.tr(),
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
