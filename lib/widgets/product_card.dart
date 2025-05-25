import 'package:app/models/product.dart';
import 'package:app/product/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsPage(product: widget.product),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF74B625),
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF74B625),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0.1,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              width: 0.2,
              color: Colors.grey.shade400,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                alignment: Alignment.topRight,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.product.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: isFavourite ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        widget.product.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${widget.product.price}",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextSpan(
                                text: " LE /${widget.product.unit}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton.filled(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
