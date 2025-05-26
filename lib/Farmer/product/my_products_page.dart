import 'package:app/Farmer/product/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'edit_product_page.dart';
import 'product_details_page.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Fresh Tomatoes',
      'description': 'Grown organically without chemicals.',
      'price': '10',
      'unit': 'kg',
      'address': 'Green Valley Farm',
      'image': 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce',
    },
    {
      'name': 'Fresh Apples',
      'description': 'Grown organically without chemicals.',
      'price': '10',
      'unit': 'kg',
      'address': 'Green Valley Farm',
      'image':
          'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce',
    },
    {
      'name': 'Organic Cucumbers',
      'description': 'Crunchy and fresh cucumbers.',
      'price': '8',
      'unit': 'kg',
      'address': 'Sunrise Field',
      'image': 'https://images.unsplash.com/photo-1615485737880-e43a5d4c68ba',
    },
  ];

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _goToAddProductPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FarmerAddProductPage()),
    );
  }

  void _goToEditProductPage(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerEditProductPage(product: product),
      ),
    );
  }

  void _goToProductDetails(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF74B625),
        title: Text(
          'Farmer_J.my_products'.tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _goToAddProductPage,
            tooltip: 'Farmer_J.add_product'.tr(),
          ),
        ],
      ),
      body: _products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Farmer_J.no_products'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _goToAddProductPage,
                    icon: const Icon(Icons.add),
                    label: Text('Farmer_J.add_product'.tr()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF74B625),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return GestureDetector(
                  onTap: () => _goToProductDetails(product),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.network(
                            product['image'],
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF242422),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product['description'],
                                style:
                                    const TextStyle(color: Color(0xFF4A4A4A)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${'Farmer_J.product_price'.tr()}: ${product['price']} / ${product['unit']}',
                                style: const TextStyle(
                                  color: Color(0xFF242422),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${'Farmer_J.product_address'.tr()}: ${product['address']}',
                                style:
                                    const TextStyle(color: Color(0xFF4A4A4A)),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    onPressed: () =>
                                        _goToEditProductPage(product),
                                    icon: const Icon(Icons.edit,
                                        color: Color(0xFF74B625)),
                                    label: Text(
                                      'Farmer_J.edit'.tr(),
                                      style: const TextStyle(
                                          color: Color(0xFF74B625)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton.icon(
                                    onPressed: () => _deleteProduct(index),
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    label: Text(
                                      'Farmer_J.delete'.tr(),
                                      style:
                                          const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
