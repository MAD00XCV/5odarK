import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/order.dart';
import '../product/product_details_page.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.order});

  final Order order;

  String getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return 'orderStatus.delivered'.tr();
      case OrderStatus.inDelivery:
        return 'orderStatus.inDelivery'.tr();
      case OrderStatus.canceled:
        return 'orderStatus.canceled'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCanceled = order.status == OrderStatus.canceled;

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: AppBar(
        title: Text('myOrders.detailsTitle'.tr()),
        backgroundColor: isCanceled ? Colors.red : const Color(0xFF74B625),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 140),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFF74B625),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailsPage(product: item.product),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.product.image,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                                '${'myOrders.quantity'.tr()}: ${item.quantity}'),
                            Text(
                                '${'myOrders.unitPrice'.tr()}: ${item.unitPrice} LE'),
                            Text(
                                '${'myOrders.totalItemPrice'.tr()}: ${item.totalPrice.toStringAsFixed(2)} LE'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border(
                  top: BorderSide(color: Color(0xFF74B625), width: 1.5),
                ),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'totalPrice'.tr()}: ${order.totalPrice.toStringAsFixed(2)} LE',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF74B625),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${'myOrders.deliveryMethod'.tr()}: ${order.deliveryMethod}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    '${'myOrders.status'.tr()}: ${getStatusText(order.status)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isCanceled ? Colors.red : const Color(0xFF555555),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
