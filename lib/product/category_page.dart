import 'package:app/product/product_details_page.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../product/products.dart';

class CategoryPage extends StatefulWidget {
  final String title;

  const CategoryPage({super.key, required this.title});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final Set<Product> favouriteProducts = {};

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = products.take(5).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF74B625),
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) {
          final product = categoryProducts[index];
          final isFav = favouriteProducts.contains(product);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsPage(product: product),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF74B625),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
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
                      "${product.price} LE / ${product.unit}",
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
                trailing: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFav) {
                        favouriteProducts.remove(product);
                      } else {
                        favouriteProducts.add(product);
                      }
                    });
                  },
                  child: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
