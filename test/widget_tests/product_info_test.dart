import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/widgets/add_to_cart_dialog.dart';
import 'package:union_shop/widgets/product_info.dart';

void main() {
  group('ProductInfo', () {
    Widget createTestWidget({
      String title = 'Test Product',
      String price = '£10.00',
      String description = 'A great product.',
      bool showOptions = true,
    }) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: ProductInfo(
              title: title,
              price: price,
              description: description,
              showOptions: showOptions,
              productId: 'test_id',
              imageUrl: 'assets/images/test.png',
            ),
          ),
        ),
      );
    }

    testWidgets('renders title, price, and description',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);
      expect(find.text('A great product.'), findsOneWidget);
    });

    testWidgets('quantity can be changed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Initial quantity is 1
      expect(find.text('1'), findsOneWidget);

      // Change quantity
      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('color and size can be selected', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Select a color
      await tester.tap(find.text('White'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Blue').last);
      await tester.pumpAndSettle();
      expect(find.text('Blue'), findsOneWidget);

      // Select a size
      await tester.tap(find.text('M'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('L').last);
      await tester.pumpAndSettle();
      expect(find.text('L'), findsOneWidget);
    });

    testWidgets('tapping "Add to Cart" shows confirmation dialog',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.text('ADD TO CART'));
      await tester.pump(); // Let the dialog appear

      expect(find.byType(AddToCartDialog), findsOneWidget);
      expect(find.text('Added to Cart!'), findsOneWidget);
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets('renders "Buy with Shop" button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('BUY WITH SHOP'), findsOneWidget);
    });

    testWidgets('does not show options when showOptions is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(showOptions: false));

      // Dropdowns for color and size should not be present
      expect(find.text('Color'), findsNothing);
      expect(find.text('Size'), findsNothing);
    });
  });
}
