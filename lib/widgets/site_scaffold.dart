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
                      // Left (opening hours) constrained to boxWidth
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: boxWidth),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Opening Hours',
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              ' Winter Break Closure Dates ',
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontWeight: FontWeight.w700,
                                fontFamilyFallback: ['NotoColorEmoji'],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('Closing 4pm 19/12/2025',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontStyle: FontStyle.italic)),
                            SizedBox(height: 4),
                            Text('Reopening 10am 05/01/2026',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontStyle: FontStyle.italic)),
                            SizedBox(height: 4),
                            Text('Last post date: 12pm on 18/12/2025',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontStyle: FontStyle.italic)),
                            SizedBox(height: 12),
                            Divider(color: Colors.black26),
                            SizedBox(height: 12),
                            Text('(Term Time)',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 6),
                            Text('Monday - Friday 10am - 4pm',
                                style: TextStyle(fontFamily: 'NotoSans')),
                            SizedBox(height: 12),
                            Text('(Outside of Term Time / Consolidation Weeks)',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 6),
                            Text('Monday - Friday 10am - 3pm',
                                style: TextStyle(fontFamily: 'NotoSans')),
                            SizedBox(height: 12),
                            Text('Purchase online 24/7',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Middle (help/info)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Help and Information',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
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
                          const SizedBox(height: 6),
                          TextButton(
                            onPressed: _placeholder,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft,
                            ),
                            child: const Text('Terms & Conditions of Sale',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    color: Colors.black87)),
                          ),
                          const SizedBox(height: 6),
                          TextButton(
                            onPressed: _placeholder,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft,
                            ),
                            child: const Text('Policy',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    color: Colors.black87)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Right (newsletter signup)
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Latest Offers',
                              style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87)),
                          SizedBox(height: 8),

                          // Newsletter widget handles input + subscribe
                          NewsletterWidget(maxWidth: kFooterLeftMax),
                        ],
                      ),
                    ],
                  );
                }

                // Center the footer content with dynamic side gutters.
                // When the window is wider than `maxContentWidth`, compute
                // symmetric horizontal padding so the content stays centered.
                final double maxContentWidth = 1000.0;
                final double horizontalPadding =
                    constraints.maxWidth > maxContentWidth
                        ? (constraints.maxWidth - maxContentWidth) / 2
                        : 24.0;
                // Responsive gap between footer columns (grows on wide screens)
                final double horizontalGap = constraints.maxWidth > 1200
                    ? 64.0
                    : constraints.maxWidth > 900
                        ? 48.0
                        : 32.0;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 4,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: boxWidth),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Opening Hours',
                                style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                ' Winter Break Closure Dates ',
                                style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w700,
                                  fontFamilyFallback: ['NotoColorEmoji'],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text('Closing 4pm 19/12/2025',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontStyle: FontStyle.italic)),
                              SizedBox(height: 4),
                              Text('Reopening 10am 05/01/2026',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontStyle: FontStyle.italic)),
                              SizedBox(height: 4),
                              Text('Last post date: 12pm on 18/12/2025',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontStyle: FontStyle.italic)),
                              SizedBox(height: 12),
                              Divider(color: Colors.black26),
                              SizedBox(height: 12),
                              Text('(Term Time)',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontWeight: FontWeight.w700)),
                              SizedBox(height: 6),
                              Text('Monday - Friday 10am - 4pm',
                                  style: TextStyle(fontFamily: 'NotoSans')),
                              SizedBox(height: 12),
                              Text(
                                  '(Outside of Term Time / Consolidation Weeks)',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontWeight: FontWeight.w700)),
                              SizedBox(height: 6),
                              Text('Monday - Friday 10am - 3pm',
                                  style: TextStyle(fontFamily: 'NotoSans')),
                              SizedBox(height: 12),
                              Text('Purchase online 24/7',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: horizontalGap),
                      Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Help and Information',
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
                            const SizedBox(height: 6),
                            TextButton(
                              onPressed: _placeholder,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft,
                              ),
                              child: const Text('Terms & Conditions of Sale',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      color: Colors.black87)),
                            ),
                            const SizedBox(height: 6),
                            TextButton(
                              onPressed: _placeholder,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft,
                              ),
                              child: const Text('Policy',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      color: Colors.black87)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: horizontalGap),
                      const Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Latest Offers',
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black87)),
                            SizedBox(height: 8),

                            // Newsletter widget handles input + subscribe
                            NewsletterWidget(maxWidth: kFooterLeftMax),
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
