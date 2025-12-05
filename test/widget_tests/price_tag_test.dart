import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/price_tag.dart';

void main() {
  group('PriceTag', () {
    Widget createTestWidget({
      required String priceText,
      bool isOnSale = false,
      int? basePricePence,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: PriceTag(
            priceText: priceText,
            isOnSale: isOnSale,
            basePricePence: basePricePence,
          ),
        ),
      );
    }

    testWidgets('displays regular price correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(priceText: '£10.00'));

      expect(find.text('£10.00'), findsOneWidget);
      // Ensure there is no strikethrough style
      final text = tester.widget<Text>(find.text('£10.00'));
      expect(text.style?.decoration, isNot(TextDecoration.lineThrough));
    });

    testWidgets('displays sale price with strikethrough for original price',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(createTestWidget(priceText: '£10.00', isOnSale: true));

      // Original price with strikethrough
      final originalPriceText = tester.widget<Text>(find.text('£10.00'));
      expect(originalPriceText.style?.decoration, TextDecoration.lineThrough);

      // Sale price (20% off £10.00 is £8.00)
      expect(find.text('£8.00'), findsOneWidget);
    });

    testWidgets('calculates price from basePricePence when provided',
        (WidgetTester tester) async {
      // 1250 pence = £12.50
      await tester.pumpWidget(createTestWidget(
        priceText: '', // priceText is ignored
        basePricePence: 1250,
      ));

      expect(find.text('£12.50'), findsOneWidget);
    });

    testWidgets('calculates sale price from basePricePence',
        (WidgetTester tester) async {
      // 2000 pence = £20.00. 20% off is £16.00
      await tester.pumpWidget(createTestWidget(
        priceText: '', // priceText is ignored
        basePricePence: 2000,
        isOnSale: true,
      ));

      final originalPriceText = tester.widget<Text>(find.text('£20.00'));
      expect(originalPriceText.style?.decoration, TextDecoration.lineThrough);

      expect(find.text('£16.00'), findsOneWidget);
    });
  });
}
