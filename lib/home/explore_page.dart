import 'package:flutter/material.dart';
import 'package:app/product/products.dart';
import 'package:app/widgets/product_card.dart';
import 'package:app/product/category_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  void _showCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'contact_us'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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

  void _navigateToCategory(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryPage(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'search_hint'.tr(),
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: const BorderRadius.all(Radius.circular(99)),
                            ),
                            // prefixIcon: const Icon(IconlyLight.search),
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                    Text(
                                      'free_support_desc'.tr(),
                                      style: const TextStyle(color: Colors.black87),
                                    ),
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
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _CategoryHeaderDelegate(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryItem(context, 'assets/images/fruits.jpg', 'fruits'.tr()),
                    _buildCategoryItem(context, 'assets/images/vegetables.jpg', 'vegetables'.tr()),
                    _buildCategoryItem(context, 'assets/images/milk&eeg.jpg', 'dairy'.tr()),
                    _buildCategoryItem(context, 'assets/images/beverages.jpg', 'fresh'.tr()),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('featured_products'.tr(), style: Theme.of(context).textTheme.titleMedium),
                  TextButton(
                    onPressed: () => _navigateToCategory(context, 'fresh'.tr()),
                    child: Text('see_all'.tr()),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductCard(product: products[index]),
                childCount: products.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.999,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String imgPath, String title) {
    return SizedBox(
      width: 70,
      child: GestureDetector(
        onTap: () => _navigateToCategory(context, title),
        child: Column(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF74B625), width: 2),
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xAA74B625),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}

class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _CategoryHeaderDelegate({required this.child});

  @override
  double get minExtent => 110;
  @override
  double get maxExtent => 110;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFEEF2E3),
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
