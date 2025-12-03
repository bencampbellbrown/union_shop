import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_scaffold.dart';
import 'package:union_shop/widgets/product_gallery.dart';
import 'package:union_shop/widgets/product_info.dart';

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
          // Product details (responsive two-column layout)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(24),
            child: LayoutBuilder(builder: (context, constraints) {
              final isDesktop = MediaQuery.of(context).size.width > 1000;
              final images = [productImage];
              return isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: gallery
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 520,
                            child: ProductGallery(images: images),
                          ),
                        ),
                        const SizedBox(width: 48),
                        // Right: info
                        Expanded(
                          flex: 1,
                          child: ProductInfo(
                            title: productTitle,
                            price: productPrice,
                            description:
                                'This is a placeholder description for the product. Replace with real product information.',
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 340,
                          child: ProductGallery(images: images),
                        ),
                        const SizedBox(height: 24),
                        ProductInfo(
                          title: productTitle,
                          price: productPrice,
                          description:
                              'This is a placeholder description for the product. Replace with real product information.',
                        ),
                      ],
                    );
            }),
          ),
        ],
      ),
    );
  }
}
