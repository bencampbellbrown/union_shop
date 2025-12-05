import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/providers/cart_provider.dart';

void main() {
  group('Product Page Tests', () {
    Widget createTestWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: ProductPage(),
          ),
        ),
      );
    }

    testWidgets('should display product title and price', (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that product title and price are displayed
      expect(find.text('Placeholder Product Name'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
    });

    testWidgets('should display add to cart button', (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that ADD TO CART button is present
      expect(find.text('ADD TO CART'), findsOneWidget);
    });

    testWidgets('should add item to cart when button is tapped',
        (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Scroll to make the button visible
      await tester.ensureVisible(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      // Tap the ADD TO CART button
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();

      // Dialog should appear with success message
      expect(find.text('Added to Cart!'), findsOneWidget);

      // Wait for the 3-second auto-close timer to complete
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });
  });
}
