import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/auth_page.dart';
import 'package:union_shop/pages/collection_page.dart';
import 'package:union_shop/pages/cart_page.dart';
import 'package:union_shop/widgets/site_scaffold.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/pages/sale_page.dart';
import 'package:union_shop/pages/search_results_page.dart';
import 'package:union_shop/widgets/price_tag.dart';
import 'package:union_shop/widgets/hero_banner.dart';
import 'package:union_shop/repositories/banner_repository.dart';
import 'package:union_shop/widgets/collection_preview.dart';

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
        '/cart': (context) => const CartPage(),
        '/sale': (context) => const SalePage(),
        '/search': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>?;
          final query = args?['query'] as String? ?? '';
          return SearchResultsPage(query: query);
        },
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

  @override
  Widget build(BuildContext context) {
    // Use SiteScaffold for consistent header/footer across pages.
    return SiteScaffold(
      child: Column(
        children: [
          // Hero Banner
          HeroBanner(
            banners: BannerRepository.getBanners(),
          ),
          const SizedBox(height: 32),

          // Products Section with Collection Previews
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
              child: Column(
                children: [
                  // Signature Collection
                  CollectionPreview(
                    collectionTitle: 'Signature & Essential Range',
                    categoryFilter: 'signature',
                    itemsToShow: 3,
                    showViewAllButton: true,
                  ),
                  const SizedBox(height: 56),

                  // Clothing Collection
                  CollectionPreview(
                    collectionTitle: 'Clothing',
                    categoryFilter: 'clothing',
                    itemsToShow: 3,
                    showViewAllButton: true,
                  ),
                  const SizedBox(height: 56),

                  // Merchandise Collection
                  CollectionPreview(
                    collectionTitle: 'Merchandise',
                    categoryFilter: 'merchandise',
                    itemsToShow: 3,
                    showViewAllButton: true,
                  ),
                  const SizedBox(height: 56),

                  // Portsmouth Collection
                  CollectionPreview(
                    collectionTitle: 'Portsmouth City Collection',
                    categoryFilter: 'portsmouth',
                    itemsToShow: 3,
                    showViewAllButton: true,
                  ),
                  const SizedBox(height: 56),

                  // Graduation Collection
                  CollectionPreview(
                    collectionTitle: 'Graduation',
                    categoryFilter: 'graduation',
                    itemsToShow: 3,
                    showViewAllButton: true,
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
  final String? productId;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.isOnSale = false,
    this.productId,
  });

  factory ProductCard.fromProduct(Product product) {
    return ProductCard(
      title: product.title,
      price: product.price,
      imageUrl: product.imageUrl,
      isOnSale: product.isOnSale,
      productId: product.id,
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
          'productId': productId,
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
