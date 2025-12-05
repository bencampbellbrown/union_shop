import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/product_gallery.dart';

void main() {
  group('ProductGallery', () {
    final testImages = [
      'assets/images/image1.jpg',
      'assets/images/image2.jpg',
      'assets/images/image3.jpg',
    ];

    Widget createTestWidget(List<String> images) {
      return MaterialApp(
        home: Scaffold(
          body: ProductGallery(images: images),
        ),
      );
    }

    testWidgets('renders main image and thumbnails',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testImages));

      // The main image is displayed, plus thumbnails
      expect(find.byType(Image), findsNWidgets(1 + testImages.length));
      expect(find.byType(GestureDetector), findsNWidgets(testImages.length));
    });

    testWidgets('tapping a thumbnail changes the main image',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testImages));

      final state = tester.state(find.byType(ProductGallery)) as dynamic;
      expect(state._selected, 0);

      // Tap the third thumbnail.
      await tester.tap(find.byType(GestureDetector).last);
      await tester.pumpAndSettle();

      // The selected index in the state should now be 2.
      expect(state._selected, 2);
    });

    testWidgets('handles empty image list gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget([]));

      // Should show a placeholder.
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
      expect(find.byType(GestureDetector), findsNothing); // No thumbnails.
    });

    testWidgets('handles a single image (no thumbnails)',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(['assets/images/image1.jpg']));

      expect(find.byType(Image), findsNWidgets(2));
      // The thumbnail list should be built.
      expect(find.byType(GestureDetector), findsOneWidget);
    });
  });
}
