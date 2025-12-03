import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_scaffold.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final productTitle = args != null && args['title'] != null
        ? args['title'] as String
        : 'Placeholder Product Name';
    final productPrice = args != null && args['price'] != null
        ? args['price'] as String
        : '£15.00';
    final productImage = args != null && args['imageUrl'] != null
        ? args['imageUrl'] as String
        : 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282';
    // Use SiteScaffold to provide consistent header/footer
    return SiteScaffold(
      child: Column(
        children: [
          // Product details
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      productImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_not_supported,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Image unavailable',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Product name
                Text(
                  productTitle,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 12),

                // Product price
                Text(
                  productPrice,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4d2963),
                  ),
                ),

                const SizedBox(height: 16),

                // Action buttons (placeholders — intentionally non-functional)
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {}, // no-op placeholder
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black12),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                      ),
                      child: const Text('ADD TO CART'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {}, // no-op placeholder
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                      ),
                      child: const Text('BUY WITH SHOP'),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'More payment options',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Product description
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This is a placeholder description for the product. Students should replace this with real product information and implement proper data management.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
