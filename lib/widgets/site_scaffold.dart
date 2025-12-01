import 'package:flutter/material.dart';
import 'package:union_shop/src/layout_constants.dart';
import 'package:union_shop/widgets/newsletter_widget.dart';

/// Reusable scaffold that provides the site header and footer around [child].
class SiteScaffold extends StatelessWidget {
  final Widget child;
  const SiteScaffold({super.key, required this.child});

  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void _navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void _placeholder() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: const Color(0xFF4d2963),
                    child: const Text(
                      'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  // main header row
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: LayoutBuilder(
                      builder: (ctx, headerConstraints) {
                        final bool isNarrow =
                            headerConstraints.maxWidth < kHeaderCompactWidth;

                        Widget iconRow = Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.search,
                                  size: 18, color: Colors.grey),
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(
                                  minWidth: 32, minHeight: 32),
                              onPressed: _placeholder,
                            ),
                            IconButton(
                              icon: const Icon(Icons.person_outline,
                                  size: 18, color: Colors.grey),
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(
                                  minWidth: 32, minHeight: 32),
                              onPressed: _placeholder,
                            ),
                            IconButton(
                              icon: const Icon(Icons.shopping_bag_outlined,
                                  size: 18, color: Colors.grey),
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(
                                  minWidth: 32, minHeight: 32),
                              onPressed: _placeholder,
                            ),
                          ],
                        );

                        Widget navLinks = Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () => _navigateToHome(context),
                              child: const Text('Home',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(width: 12),
                            TextButton(
                              onPressed: () => _navigateToProduct(context),
                              child: const Text('Shop',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(width: 12),
                            TextButton(
                              onPressed: _placeholder,
                              child: const Text('The Print Shack',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(width: 12),
                            TextButton(
                              onPressed: _placeholder,
                              child: const Text('SALE!',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(width: 12),
                            TextButton(
                              onPressed: () => _navigateToAbout(context),
                              child: const Text('About',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                          ],
                        );

                        if (isNarrow) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () => _navigateToHome(context),
                                child: Image.network(
                                  'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                  height: 18,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      width: 18,
                                      height: 18,
                                      child: const Center(
                                        child: Icon(Icons.image_not_supported,
                                            color: Colors.grey),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Row(mainAxisSize: MainAxisSize.min, children: [
                                iconRow,
                                PopupMenuButton<String>(
                                  icon: const Icon(Icons.menu,
                                      size: 20, color: Colors.grey),
                                  onSelected: (value) {
                                    switch (value) {
                                      case 'home':
                                        _navigateToHome(context);
                                        break;
                                      case 'shop':
                                        _navigateToProduct(context);
                                        break;
                                      case 'about':
                                        _navigateToAbout(context);
                                        break;
                                      default:
                                        _placeholder();
                                    }
                                  },
                                  itemBuilder: (ctx) => const [
                                    PopupMenuItem(
                                        value: 'home', child: Text('Home')),
                                    PopupMenuItem(
                                        value: 'shop', child: Text('Shop')),
                                    PopupMenuItem(
                                        value: 'print',
                                        child: Text('The Print Shack')),
                                    PopupMenuItem(
                                        value: 'sale', child: Text('SALE!')),
                                    PopupMenuItem(
                                        value: 'about', child: Text('About')),
                                  ],
                                ),
                              ])
                            ],
                          );
                        }

                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () => _navigateToHome(context),
                              child: Image.network(
                                'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                height: 18,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    width: 18,
                                    height: 18,
                                    child: const Center(
                                      child: Icon(Icons.image_not_supported,
                                          color: Colors.grey),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(child: Center(child: navLinks)),
                            iconRow,
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Page content
            child,

            // Footer
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: LayoutBuilder(builder: (context, constraints) {
                final double boxWidth = constraints.maxWidth > 720
                    ? 520
                    : constraints.maxWidth * 0.95;

                final bool isNarrow = constraints.maxWidth < kFooterStackWidth;

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: boxWidth),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Opening Hours',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Help and Information',
                              style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                  fontSize: 16)),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: _placeholder,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft,
                            ),
                            child: const Text('Search',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    color: Colors.black87)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Latest Offers',
                              style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87)),
                          const SizedBox(height: 8),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: boxWidth),
                            child: NewsletterWidget(),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 4,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: boxWidth),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Opening Hours',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Help and Information',
                                style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                  fontSize: 16,
                                )),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: _placeholder,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft,
                              ),
                              child: const Text('Search',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      color: Colors.black87)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Latest Offers',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black87)),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                color: Colors.white,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email address',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _placeholder,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4d2963),
                                  foregroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text(
                                  'SUBSCRIBE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
