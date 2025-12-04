import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page hero banner', (tester) async {
      await tester.pumpWidget(const UnionShopApp());

      // Check that banner text contains "BIG SALE"
      expect(
          find.byWidgetPredicate(
              (w) => w is Text && (w.data ?? '').contains('BIG SALE')),
          findsOneWidget);
    });

    testWidgets('should have cart provider initialized', (tester) async {
      await tester.pumpWidget(const UnionShopApp());

      // Verify the app runs without provider errors
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('should display search icon in header', (tester) async {
      await tester.pumpWidget(const UnionShopApp());

      // Check that search icon is present
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should display cart icon in header', (tester) async {
      await tester.pumpWidget(const UnionShopApp());

      // Check that shopping cart icon is present
      expect(find.byIcon(Icons.shopping_basket_outlined), findsOneWidget);
    });

    testWidgets('should display footer with opening hours', (tester) async {
      await tester.pumpWidget(const UnionShopApp());

      // Scroll to find footer
      await tester.pumpAndSettle();

      // Check that footer sections are present
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
    });
  });
}
