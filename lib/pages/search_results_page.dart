import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_scaffold.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/models/product.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  ProductSortOption _sortOption = ProductSortOption.nameAsc;

  List<Product> _getSearchResults() =>
      ProductRepository.searchProducts(widget.query);

  List<Product> _getSortedProducts() {
    final products = _getSearchResults();
    switch (_sortOption) {
      case ProductSortOption.nameAsc:
        return ProductRepository.sortByName(products, ascending: true);
      case ProductSortOption.nameDesc:
        return ProductRepository.sortByName(products, ascending: false);
      case ProductSortOption.priceAsc:
        return ProductRepository.sortByPrice(products, ascending: true);
      case ProductSortOption.priceDesc:
        return ProductRepository.sortByPrice(products, ascending: false);
      default:
        return products;
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = _getSearchResults();
    final sortedResults = _getSortedProducts();

    // Compute responsive columns and aspect ratio for product grid
    final double width = MediaQuery.of(context).size.width;
    final int columns = width > 1000 ? 3 : (width > 600 ? 2 : 1);
    final double childAspect = columns == 3 ? 1.0 : (columns == 2 ? 1.2 : 0.8);

    return SiteScaffold(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            child: Column(
              children: [
                Text(
                  'Search results for "${widget.query}"',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  results.isEmpty
                      ? '(No results)'
                      : '(${results.length} result${results.length != 1 ? 's' : ''})',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Products Grid or Empty State
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: results.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off,
                              size: 80,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'No results found for "${widget.query}"',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Try different keywords',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        // Sort dropdown
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButton<ProductSortOption>(
                              value: _sortOption,
                              onChanged: (ProductSortOption? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _sortOption = newValue;
                                  });
                                }
                              },
                              items: const [
                                DropdownMenuItem(
                                  value: ProductSortOption.nameAsc,
                                  child: Text('Name: A-Z'),
                                ),
                                DropdownMenuItem(
                                  value: ProductSortOption.nameDesc,
                                  child: Text('Name: Z-A'),
                                ),
                                DropdownMenuItem(
                                  value: ProductSortOption.priceAsc,
                                  child: Text('Price: Low-High'),
                                ),
                                DropdownMenuItem(
                                  value: ProductSortOption.priceDesc,
                                  child: Text('Price: High-Low'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Product Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columns,
                            childAspectRatio: childAspect,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: sortedResults.length,
                          itemBuilder: (context, index) {
                            final product = sortedResults[index];
                            return ProductCard.fromProduct(product);
                          },
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
