import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/providers/cart_provider.dart';

void main() {
  group('About Page Tests', () {
    // Helper function to create a testable widget with necessary providers
    Widget createTestWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: const MaterialApp(
          home: AboutPage(),
        ),
      );
    }

    testWidgets('should display the main title', (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that the main title "About us" is displayed
      expect(find.text('About us'), findsOneWidget);
    });

    testWidgets('should display the introductory text', (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check for the welcome message
      expect(find.text('Welcome to the Union Shop!'), findsOneWidget);
    });

    testWidgets('should display the main content paragraphs', (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check for a key sentence from the body
      expect(
        find.text(
            'We\'re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!',
            findRichText: true),
        findsOneWidget,
      );

      expect(
        find.text(
            'All online purchases are available for delivery or instore collection!',
            findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('should display contact information', (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that the contact email is present
      expect(
        find.text(
            'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us at hello@upsu.net.',
            findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('should display the closing message', (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check for the closing remarks
      expect(find.text('Happy shopping!'), findsOneWidget);
      expect(find.text('The Union Shop & Reception Team'), findsOneWidget);
    });
  });
}
