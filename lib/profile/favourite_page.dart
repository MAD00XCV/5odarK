import 'package:flutter/material.dart';
import '../models/product.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  final List<Product> favouriteProducts = const [
    Product(
      name: "Strawberries",
      description: "Strawberries are nutricious",
      image: 'assets/images/straw.jpg',
      price: 25,
      unit: "Kg",
      rating: 4.35,
      category: "Fruits",
    ),
    Product(
      name: "Potatoes",
      description: "Potatoes are nutricious",
      image: 'assets/images/potato.jpg',
      price: 12,
      unit: "Kg",
      rating: 8.45,
      category: "Vegetables",
    ),
    Product(
      name: "Watermelons",
      description: "Watermelons are nutricious",
      image: 'assets/images/watermelon.jpg',
      price: 25,
      unit: "Kg",
      rating: 6.5,
      category: "Fruits",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      body: ListView.builder(
        itemCount: favouriteProducts.length,
        itemBuilder: (context, index) {
          final product = favouriteProducts[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF74B625),
                  blurRadius: 8,
                  spreadRadius: 1,
                )
              ],
              border: Border.all(color: Color(0xFF74B625), width: 1),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  product.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF242422),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: const TextStyle(color: Color(0xFF242422)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${product.price} LE /${product.unit} ',
                    style: const TextStyle(color: Color(0xFF242422)),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(color: Color(0xFF242422)),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.favorite,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
