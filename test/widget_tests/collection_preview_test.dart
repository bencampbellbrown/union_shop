import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/widgets/collection_preview.dart';
import 'package:union_shop/main.dart' show ProductCard;

void main() {
  group('CollectionPreview', () {
    Widget createTestWidget({
      required String collectionTitle,
      required String categoryFilter,
      int itemsToShow = 3,
      bool showViewAllButton = true,
    }) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: CollectionPreview(
              collectionTitle: collectionTitle,
              categoryFilter: categoryFilter,
              itemsToShow: itemsToShow,
              showViewAllButton: showViewAllButton,
            ),
          ),
        ),
      );
    }

    testWidgets('renders title and "View All" button',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        collectionTitle: 'Test Collection',
        categoryFilter: 'clothing',
      ));

      expect(find.text('Test Collection'), findsOneWidget);
      expect(find.text('View All'), findsOneWidget);
    });

    testWidgets(
        'does not render "View All" button when showViewAllButton is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        collectionTitle: 'Test Collection',
        categoryFilter: 'clothing',
        showViewAllButton: false,
      ));

      expect(find.text('View All'), findsNothing);
    });

    testWidgets('displays correct number of product cards',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        collectionTitle: 'Clothing',
        categoryFilter: 'clothing',
        itemsToShow: 2,
      ));

      // Assuming ProductRepository returns at least 2 clothing items
      expect(find.byType(ProductCard), findsNWidgets(2));
    });

    testWidgets('handles empty product list gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        collectionTitle: 'Empty Collection',
        categoryFilter: 'nonexistent-category',
        itemsToShow: 3,
      ));

      expect(find.text('Empty Collection'), findsOneWidget);
      expect(find.byType(ProductCard), findsNothing);
    });

    testWidgets('"View All" button is tappable', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        collectionTitle: 'Test Collection',
        categoryFilter: 'clothing',
      ));

      // This test just ensures the button is present and can be tapped without error.
      // Navigation testing would require a more complex setup with a Navigator.
      await tester.tap(find.text('View All'));
      await tester.pumpAndSettle();
    });
  });
}
