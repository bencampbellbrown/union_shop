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
  String _selectedColor = 'White';
  int _selectedIndex = 0;

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

    // Define available color variants and their images. You can replace
    // these with dynamic data from your backend later.
    final colorOptions = ['White', 'Blue'];
    final variantImages = {
      'White': 'assets/images/white_hoddie.png',
      'Blue': 'assets/images/blue_hoddie_2.png',
    };

    // If a single image was passed via args prefer that as the default
    if (productImageArg != null) {
      variantImages[_selectedColor] = productImageArg;
    }

    // Ensure selectedColor is valid and compute images list in the same
    // order as colorOptions so selectedIndex matches.
    if (!colorOptions.contains(_selectedColor))
      _selectedColor = colorOptions.first;
    final images = colorOptions
        .map((c) => variantImages[c] ?? variantImages[colorOptions.first]!)
        .toList();
    _selectedIndex = colorOptions.indexOf(_selectedColor);

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
                            child: ProductGallery(
                              images: images,
                              selectedIndex: _selectedIndex,
                              onSelect: (idx) => setState(() {
                                _selectedIndex = idx;
                                _selectedColor = colorOptions[idx];
                              }),
                            ),
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
                            colorOptions: colorOptions,
                            selectedColor: _selectedColor,
                            onColorChanged: (color) => setState(() {
                              _selectedColor = color;
                              _selectedIndex = colorOptions.indexOf(color);
                            }),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 340,
                          child: ProductGallery(
                            images: images,
                            selectedIndex: _selectedIndex,
                            onSelect: (idx) => setState(() {
                              _selectedIndex = idx;
                              _selectedColor = colorOptions[idx];
                            }),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ProductInfo(
                          title: productTitle,
                          price: productPrice,
                          description:
                              'This is a placeholder description for the product. Replace with real product information.',
                          colorOptions: colorOptions,
                          selectedColor: _selectedColor,
                          onColorChanged: (color) => setState(() {
                            _selectedColor = color;
                            _selectedIndex = colorOptions.indexOf(color);
                          }),
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
