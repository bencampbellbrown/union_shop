import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_scaffold.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/models/product.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  ProductSortOption _sortOption = ProductSortOption.priceDesc;

  List<Product> _getFiltered() =>
      ProductRepository.getAllProducts().where((p) => p.isOnSale).toList();

  List<Product> _getSortedProducts() {
    final products = _getFiltered();
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
    final filtered = _getFiltered();

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
                const Text(
                  'Sale',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '${filtered.length} product${filtered.length != 1 ? 's' : ''}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Products Grid + Sort
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: filtered.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text(
                          'No products are currently on sale.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButton<ProductSortOption>(
                              value: _sortOption,
                              onChanged: (option) {
                                if (option != null) {
                                  setState(() {
                                    _sortOption = option;
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
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: columns,
                          childAspectRatio: childAspect,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 48,
                          children: _getSortedProducts()
                              .map((product) => ProductCard(
                                    title: product.title,
                                    price: product.price,
                                    imageUrl: product.imageUrl,
                                  ))
                              .toList(),
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
