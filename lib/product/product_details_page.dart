import 'package:app/product/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../models/product.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavourite = false;
  int quantity = 1;

  final Color primaryGreen = const Color(0xFF74B625);
  final Set<Product> favouriteProducts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: Text(
          widget.product.name,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavourite = !isFavourite;
              });
            },
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              color: isFavourite ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // صورة المنتج الرئيسي
          Container(
            height: 250,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(widget.product.image),
              ),
            ),
          ),

          // معلومات المنتج
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Available in stock",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.product.price.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextSpan(
                      text: "LE/${widget.product.unit}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // تقييم وكمية
          Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.yellow.shade600),
              Text("${widget.product.rating} (192)"),
              const Spacer(),
              SizedBox(
                width: 30,
                height: 30,
                child: IconButton.filled(
                  padding: EdgeInsets.zero,
                  onPressed: quantity > 1
                      ? () {
                          setState(() {
                            quantity--;
                          });
                        }
                      : null,
                  iconSize: 18,
                  icon: const Icon(Icons.remove),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "$quantity ${widget.product.unit}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: IconButton.filled(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  iconSize: 18,
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            "Description",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.product.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 20),

          Text(
            "Related Products",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = products[index];
                final isFav = favouriteProducts.contains(product);

                return Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x4474B625),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.asset(
                              product.image,
                              height: 110,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
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
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFav ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${product.price}/ ${product.unit} ',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: () {},
            label: const Text("Add to cart"),
            icon: const Icon(IconlyLight.bag2),
          ),
        ],
      ),
    );
  }
}
