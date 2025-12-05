import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/widgets/add_to_cart_dialog.dart';

void main() {
  group('AddToCartDialog', () {
    late CartItem testCartItem;

    setUp(() {
      testCartItem = CartItem(
        productId: '1',
        title: 'Test Product',
        price: '£10.00',
        quantity: 1,
        imageUrl: 'assets/images/test_image.png',
      );
    });

    Widget createTestWidget(Widget dialog) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => dialog,
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
          routes: {
            '/cart': (context) => const Scaffold(body: Text('Cart Page')),
          },
        ),
      );
    }

    testWidgets('renders correctly and shows item details',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          createTestWidget(AddToCartDialog(cartItem: testCartItem)));

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Added to Cart!'), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Qty: 1'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('"View My Cart" button navigates to cart page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          createTestWidget(AddToCartDialog(cartItem: testCartItem)));

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('View My Cart (1)'));
      await tester.pumpAndSettle();

      expect(find.text('Cart Page'), findsOneWidget);
    });

    testWidgets('"Continue Shopping" button closes the dialog',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          createTestWidget(AddToCartDialog(cartItem: testCartItem)));

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(AddToCartDialog), findsOneWidget);

      await tester.tap(find.text('Continue Shopping'));
      await tester.pumpAndSettle();

      expect(find.byType(AddToCartDialog), findsNothing);
    });

    testWidgets('dialog auto-closes after 3 seconds',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          createTestWidget(AddToCartDialog(cartItem: testCartItem)));

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(AddToCartDialog), findsOneWidget);

      // Wait for the duration of the auto-close timer
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.byType(AddToCartDialog), findsNothing);
    });
  });
}
