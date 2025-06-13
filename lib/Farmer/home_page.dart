import 'package:app/Farmer/home/details_statistics.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmerHomePage extends StatelessWidget {
  const FarmerHomePage({super.key});

  void _navigateToDetail(BuildContext context, String statKey) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerStatisticsDetailsPage(statKey: statKey),
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF74B625), width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4474B625),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: const Color(0xFF74B625)),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF74B625),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('contact_us'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('call_prompt'.tr()),
            const SizedBox(height: 10),
            Text(
              '+20 123 456 7890',
              style: const TextStyle(
                color: Color(0xFF74B625),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(backgroundColor: Colors.red.shade100),
            child: Text('no'.tr()),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF74B625),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(context);
              final Uri callUri = Uri(scheme: 'tel', path: '+201234567890');
              if (await canLaunchUrl(callUri)) {
                await launchUrl(callUri);
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('cannot_make_call'.tr())),
                );
              }
            },
            child: Text('call'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF74B625),
        title: Text('farmer_home'.tr(), style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFFEEF2E3))
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            /// Customer Service Section
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/con1.png"),
                        fit: BoxFit.cover,
                        opacity: 0.3,
                      ),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFF74B625),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'free_consultation'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: const Color(0xFF2E382E)),
                                ),
                                Text('free_support_desc'.tr()),
                                FilledButton(
                                  onPressed: () => _showCallDialog(context),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xFF74B625),
                                  ),
                                  child: Text('call_now'.tr()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Statistic Cards
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(
                  context: context,
                  icon: Icons.shopping_basket,
                  title: 'remaining_products',
                  value: '12',
                  onTap: () => _navigateToDetail(context, 'remaining_products'),
                ),
                
                _buildStatCard(
                  context: context,
                  icon: Icons.receipt_long,
                  title: 'orders_received',
                  value: '8',
                  onTap: () => _navigateToDetail(context, 'orders_received'),
                ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(
                  context: context,
                  icon: Icons.person,
                  title: 'buyers',
                  value: '5',
                  onTap: () => _navigateToDetail(context, 'buyers'),
                ),
                _buildStatCard(
                  context: context,
                  icon: Icons.receipt_long,
                  title: 'orders_received',
                  value: '8',
                  onTap: () => _navigateToDetail(context, 'orders_received'),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
