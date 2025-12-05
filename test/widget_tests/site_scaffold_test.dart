import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/widgets/site_scaffold.dart';

void main() {
  group('SiteScaffold', () {
    Widget createTestWidget(Widget child, {CartProvider? cartProvider}) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => cartProvider ?? CartProvider()),
        ],
        child: MaterialApp(
          home: SiteScaffold(child: child),
          routes: {
            '/': (context) => const Scaffold(body: Text('Home Page')),
            '/cart': (context) => const Scaffold(body: Text('Cart Page')),
            '/about': (context) => const Scaffold(body: Text('About Page')),
          },
        ),
      );
    }

    testWidgets('renders header, footer, and child content',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const Text('Test Child')));

      expect(find.text('The UNION'), findsOneWidget); // Header
      expect(find.text('Test Child'), findsOneWidget); // Child
      expect(find.text('Opening Hours'), findsOneWidget); // Footer
    });

    testWidgets('header navigation links are present',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Sale'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_basket_outlined), findsOneWidget);
    });

    testWidgets('cart icon navigates to cart page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));

      await tester.tap(find.byIcon(Icons.shopping_basket_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Cart Page'), findsOneWidget);
    });

    testWidgets('cart badge appears when cart is not empty',
        (WidgetTester tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(CartItem(
        productId: '1',
        title: 'Test',
        price: '10',
        quantity: 1,
        imageUrl: '',
      ));

      await tester.pumpWidget(
          createTestWidget(Container(), cartProvider: cartProvider));

      // The badge shows the number of items in the cart
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('cart badge is not visible when cart is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));

      // The badge is a Container with a specific decoration, which is hard to find directly.
      // Instead, we check that the count text '0' or any number is not there.
      // Since the badge shows item count (not total quantity), we look for '1', '2', etc.
      expect(find.text('1'), findsNothing);
    });

    testWidgets('footer contains expected text', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));

      // Scroll to the bottom to ensure the footer is visible
      await tester.drag(find.byType(SiteScaffold), const Offset(0, -1000));
      await tester.pumpAndSettle();

      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
      expect(find.text('Contact'), findsOneWidget);
    });
  });
}
