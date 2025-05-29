import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/order.dart';
import '../product/products.dart';
import 'order_details.dart';

class MyOrdersPage extends StatelessWidget {
  MyOrdersPage({super.key});

  final List<Order> orders = [
    Order(
      id: '1001',
      date: DateTime.now().subtract(const Duration(days: 1)),
      deliveryMethod: 'Home_Delivery'.tr(),
      status: OrderStatus.delivered,
      items: [
        OrderItem(product: products[0], quantity: 2, unitPrice: 5),
        OrderItem(product: products[1], quantity: 1, unitPrice: 10),
      ],
    ),
    Order(
      id: '1002',
      date: DateTime.now().subtract(const Duration(days: 3)),
      deliveryMethod:  'pickup'.tr(),
      status: OrderStatus.inDelivery,
      items: [
        OrderItem(product: products[2], quantity: 3, unitPrice: 6),
      ],
    ),
  ];

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
    return Scaffold(
      appBar: AppBar(
        title: Text('myOrders.title'.tr()),
        backgroundColor: const Color(0xFF74B625),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final isCanceled = order.status == OrderStatus.canceled;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: isCanceled ? Colors.red : const Color(0xFF74B625),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isCanceled
                      // ignore: deprecated_member_use
                      ? Colors.red.withOpacity(0.5)
                      // ignore: deprecated_member_use
                      : const Color(0xFF74B625).withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                '${'myOrders.orderNumber'.tr()} ${order.id}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${'myOrders.orderDate'.tr()}: ${DateFormat.yMMMd().format(order.date)}',
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderDetailsPage(order: order),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
