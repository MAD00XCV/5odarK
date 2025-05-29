import 'product.dart';

enum OrderStatus { delivered, inDelivery, canceled }

class OrderItem {
  final Product product;
  final int quantity;
  final double unitPrice;

  OrderItem({
    required this.product,
    required this.quantity,
    required this.unitPrice,
  });

  double get totalPrice => unitPrice * quantity;
}

class Order {
  final String id;
  final DateTime date;
  final String deliveryMethod;
  final OrderStatus status;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.date,
    required this.deliveryMethod,
    required this.status,
    required this.items,
  });

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + item.totalPrice);
}
