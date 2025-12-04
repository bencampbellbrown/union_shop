import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_scaffold.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/main.dart';

class CollectionPage extends StatelessWidget {
  final String collectionTitle;
  final String categoryFilter;
  final String? description;

  const CollectionPage({
    super.key,
    required this.collectionTitle,
    required this.categoryFilter,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Get filtered products for this collection
    final products = ProductRepository.getProductsByCategory(categoryFilter);

    // Compute responsive columns and aspect ratio for product grid
    final double width = MediaQuery.of(context).size.width;
    final int columns = width > 1000 ? 3 : (width > 600 ? 2 : 1);
    final double childAspect = columns == 3 ? 1.0 : (columns == 2 ? 1.2 : 0.8);

    return SiteScaffold(
      child: Column(
        children: [
          // Collection Header
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            child: Column(
              children: [
                Text(
                  collectionTitle,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (description != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    description!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  '${products.length} product${products.length != 1 ? 's' : ''}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Products Grid
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: products.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text(
                          'No products found in this collection.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: columns,
                      childAspectRatio: childAspect,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 48,
                      children: products
                          .map((product) => ProductCard.fromProduct(product))
                          .toList(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
