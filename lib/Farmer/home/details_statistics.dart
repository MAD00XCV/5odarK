import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FarmerStatisticsDetailsPage extends StatelessWidget {
  final String statKey;

  const FarmerStatisticsDetailsPage({super.key, required this.statKey});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> mockData;

    switch (statKey) {
      case 'remaining_products':
        mockData = List.generate(5, (index) => {
              'name': 'Product ${index + 1}',
              'qty': '${10 - index}',
              'id': 'P00${index + 1}',
            });
        break;
      case 'orders_received':
        mockData = List.generate(5, (index) => {
              'orderId': 'ORD${1000 + index}',
              'product': 'Item ${index + 1}',
              'qty': '${index + 2}',
            });
        break;
      case 'buyers':
        mockData = List.generate(5, (index) => {
              'buyerId': 'U00${index + 1}',
              'name': 'Customer ${index + 1}',
              'orders': '${index + 3}',
            });
        break;
      case 'returned_items':
        mockData = List.generate(5, (index) => {
              'product': 'Returned Product ${index + 1}',
              'orderId': 'ORDR${2000 + index}',
              'qty': '${index + 1}',
              'reason': 'Damaged during delivery',
            });
        break;
      default:
        mockData = [];
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: AppBar(
        title: Text(statKey.tr(), style: const TextStyle(color: Color(0xFFEEF2E3))),
        backgroundColor: const Color(0xFF74B625),
        iconTheme: const IconThemeData(color: Color(0xFFEEF2E3)),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockData.length,
        itemBuilder: (context, index) {
          final item = mockData[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFF74B625), width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statKey.tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF74B625),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...item.entries.map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text('${e.key.tr()}: ${e.value}'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('close'.tr()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF74B625), width: 1.5),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4474B625),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('${e.key.tr()}: ${e.value}',
                        style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
