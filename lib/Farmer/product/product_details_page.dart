import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required Map<String, dynamic> product});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF74B625),
        title: Text(
          'Farmer_J.product_details'.tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                product['image'],
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF242422),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product['description'],
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.monetization_on, color: Color(0xFF74B625)),
                const SizedBox(width: 8),
                Text(
                  '${'Farmer_J.product_price'.tr()}: ${product['price']} / ${product['unit']}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF242422),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFF74B625)),
                const SizedBox(width: 8),
                Text(
                  '${'Farmer_J.product_address'.tr()}: ${product['address']}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
