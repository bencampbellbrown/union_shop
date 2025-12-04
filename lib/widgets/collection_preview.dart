import 'package:flutter/material.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/main.dart' show ProductCard;

class CollectionPreview extends StatelessWidget {
  final String collectionTitle;
  final String categoryFilter;
  final int itemsToShow;
  final bool showViewAllButton;

  const CollectionPreview({
    super.key,
    required this.collectionTitle,
    required this.categoryFilter,
    this.itemsToShow = 3,
    this.showViewAllButton = true,
  });

  @override
  Widget build(BuildContext context) {
    // Get products filtered by category
    final products = ProductRepository.getProductsByCategory(categoryFilter);

    // Limit to itemsToShow
    final displayedProducts = products.take(itemsToShow).toList();

    // Compute responsive columns
    final double width = MediaQuery.of(context).size.width;
    final int columns = width > 1000 ? 3 : (width > 600 ? 2 : 1);
    final double childAspect = columns == 3 ? 1.0 : (columns == 2 ? 1.2 : 0.8);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Column(
        children: [
          // Header with title and "View All" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                collectionTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
              if (showViewAllButton)
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/collection/$categoryFilter',
                    );
                  },
                  label: const Text(
                    'View All',
                    style: TextStyle(
                      color: Color(0xFF4d2963),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: Color(0xFF4d2963),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),

          // Product grid
          if (displayedProducts.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  'No products in this collection',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                childAspectRatio: childAspect,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: displayedProducts.length,
              itemBuilder: (context, index) {
                final product = displayedProducts[index];
                return ProductCard.fromProduct(product);
              },
            ),
        ],
      ),
    );
  }
}
