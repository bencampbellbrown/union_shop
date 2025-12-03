import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_scaffold.dart';
import 'package:union_shop/widgets/product_gallery.dart';
import 'package:union_shop/widgets/product_info.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
    final productImageArg = args != null && args['imageUrl'] != null
        ? args['imageUrl'] as String
        : null;

    List<String> images;
    if ((productImageArg != null && productImageArg.contains('uni_hoddie')) ||
        productTitle.toLowerCase().contains('uni hood')) {
      images = [
        'assets/images/hoddies/blue_hoddie.png',
        'assets/images/hoddies/white_hoddie.png',
        'assets/images/hoddies/black_hoddie.png',
      ];
    } else if ((productImageArg != null &&
            productImageArg.contains('tshirt')) ||
        productTitle.toLowerCase().contains('t-shirt')) {
      images = [
        'assets/images/tshirts/blue_tshirt.png',
        'assets/images/tshirts/white_tshirt.png',
        'assets/images/tshirts/black_tshirt.png',
      ];
    } else if ((productImageArg != null && productImageArg.contains('cap')) ||
        productTitle.toLowerCase().contains('cap')) {
      images = [
        'assets/images/caps/blue_cap.png',
        'assets/images/caps/white_cap.png',
        'assets/images/caps/black_cap.png',
      ];
    } else {
      images = [productImageArg ?? 'assets/images/hoddies/blue_hoddie.png'];
    }

    // Determine if product should show color/size options
    final bool showOptions =
        !((productImageArg != null && productImageArg.contains('stationary')) ||
            productTitle.toLowerCase().contains('pencil'));

    // No external selection state required — gallery is self-managed.

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
                            showOptions: showOptions,
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
                          showOptions: showOptions,
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
