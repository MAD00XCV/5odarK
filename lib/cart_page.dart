import 'package:app/home/home_page.dart';
import 'package:app/product/product_details_page.dart';
import 'package:app/product/products.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> cartItems = [];

  final Color primaryGreen = const Color(0xFF74B625);

  @override
  void initState() {
    super.initState();
    cartItems.addAll(
      products.take(4).map((product) => {
            "product": product,
            "quantity": 1,
          }),
    );
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item['product'].price * item['quantity'];
    }
    return total;
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    IconlyLight.bag2,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'cart_empty'.tr(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryGreen,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text('Start_Shopping'.tr()),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...List.generate(cartItems.length, (index) {
                  final item = cartItems[index];
                  final product = item['product'];
                  final quantity = item['quantity'];
                  final itemTotal = product.price * quantity;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
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
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(product: product),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                product.image,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF242422),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => removeItem(index),
                                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${product.price} LE / ${product.unit}",
                                style: const TextStyle(
                                  color: Color(0xFF242422),
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: 18,
                                      onPressed: () => decreaseQuantity(index),
                                      icon: const Icon(Icons.remove_circle_outline),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      "$quantity",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: 18,
                                      onPressed: () => increaseQuantity(index),
                                      icon: const Icon(Icons.add_circle_outline),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Total: ${itemTotal.toStringAsFixed(2)} LE",
                                style: const TextStyle(
                                  color: Color(0xFF242422),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${'cart_total'.tr()} (${cartItems.length} ${'items'.tr()}) :",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF242422),
                      ),
                    ),
                    Text(
                      "${totalPrice.toStringAsFixed(2)} LE",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                  },
                  icon: const Icon(IconlyBold.arrowRight),
                  label: Text(
                    'Proceed_Checkout'.tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
    );
  }
}
