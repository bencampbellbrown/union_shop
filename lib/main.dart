import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/auth_page.dart';
import 'package:union_shop/pages/collection_page.dart';
import 'package:union_shop/widgets/site_scaffold.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/pages/sale_page.dart';
import 'package:union_shop/widgets/price_tag.dart';

// Returns an ImageProvider for either bundled assets or network URLs.
ImageProvider<Object> _imageProviderFor(String url) {
  if (url.startsWith('assets/')) {
    return AssetImage(url);
  }
  return NetworkImage(url);
}

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
        // Use the bundled Noto fonts (configured in pubspec.yaml) via
        // TextStyle with `fontFamily` and `fontFamilyFallback`.
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutPage(),
        '/auth': (context) => const AuthPage(),
        '/sale': (context) => const SalePage(),
        '/collection/clothing': (context) => const CollectionPage(
              collectionTitle: 'Clothing',
              categoryFilter: 'clothing',
            ),
        '/collection/merchandise': (context) => const CollectionPage(
              collectionTitle: 'Merchandise',
              categoryFilter: 'merchandise',
            ),
        '/collection/signature': (context) => const CollectionPage(
              collectionTitle: 'Signature & Essential Range',
              categoryFilter: 'signature',
            ),
        '/collection/portsmouth': (context) => const CollectionPage(
              collectionTitle: 'Portsmouth City Collection',
              categoryFilter: 'portsmouth',
            ),
        '/collection/graduation': (context) => const CollectionPage(
              collectionTitle: 'Graduation',
              categoryFilter: 'graduation',
            ),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductSortOption _sortOption = ProductSortOption.priceDesc;

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  List<Product> _getSortedProducts() {
    final products = ProductRepository.getAllProducts();
    switch (_sortOption) {
      case ProductSortOption.nameAsc:
        return ProductRepository.sortByName(products, ascending: true);
      case ProductSortOption.nameDesc:
        return ProductRepository.sortByName(products, ascending: false);
      case ProductSortOption.priceAsc:
        return ProductRepository.sortByPrice(products, ascending: true);
      case ProductSortOption.priceDesc:
        return ProductRepository.sortByPrice(products, ascending: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Compute responsive columns and aspect ratio for product grid.
    final double width = MediaQuery.of(context).size.width;
    final int columns = width > 1000 ? 3 : (width > 600 ? 2 : 1);
    // Use taller tiles for single-column (mobile) so image + text don't overflow.
    final double childAspect = columns == 3 ? 1.0 : (columns == 2 ? 1.2 : 0.8);

    // Use SiteScaffold for consistent header/footer across pages.
    return SiteScaffold(
      child: Column(
        children: [
          // Hero Section
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _imageProviderFor(
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                    ),
                  ),
                ),
                // Content overlay
                Positioned(
                  left: 24,
                  right: 24,
                  top: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Placeholder Hero Title',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "This is placeholder text for the hero section.",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: placeholderCallbackForButtons,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d2963),
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'BROWSE PRODUCTS',
                          style: TextStyle(fontSize: 14, letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Products Section
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const Text(
                    'PRODUCTS SECTION',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 24),
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
                        .map((product) => ProductCard.fromProduct(product))
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

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final bool isOnSale;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.isOnSale = false,
  });

  factory ProductCard.fromProduct(Product product) {
    return ProductCard(
      title: product.title,
      price: product.price,
      imageUrl: product.imageUrl,
      isOnSale: product.isOnSale,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 1000;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: {
          'title': title,
          'price': price,
          'imageUrl': imageUrl,
          'isOnSale': isOnSale,
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image should flex to available space so text below doesn't push
          // the tile beyond its grid cell. On desktop we use BoxFit.contain
          // and center the image so the whole image remains visible. On
          // smaller screens we keep a square AspectRatio and BoxFit.cover.
          Expanded(
            child: isDesktop
                ? Center(
                    child: ClipRRect(
                      child: Image(
                        image: _imageProviderFor(imageUrl),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      child: Image(
                        image: _imageProviderFor(imageUrl),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          PriceTag(
            priceText: price,
            isOnSale: isOnSale,
            discountPercent: 20,
          ),
        ],
      ),
    );
  }
}

// Sorting options are defined in models/product.dart
