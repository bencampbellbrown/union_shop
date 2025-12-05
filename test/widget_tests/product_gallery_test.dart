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

      // The main image is displayed.
      expect(find.byType(Image), findsOneWidget); // The main image
      // Each thumbnail is an InkWell.
      expect(find.byType(InkWell), findsNWidgets(testImages.length));
    });

    testWidgets('tapping a thumbnail changes the main image',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testImages));

      final state =
          tester.state<State<ProductGallery>>(find.byType(ProductGallery));
      final dynamic stateDynamic = state;
      expect(stateDynamic._selected, 0);

      // Tap the third thumbnail.
      await tester.tap(find.byType(InkWell).last);
      await tester.pumpAndSettle();

      // The selected index in the state should now be 2.
      expect(stateDynamic._selected, 2);
    });

    testWidgets('handles empty image list gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget([]));

      // Should show a placeholder.
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
      expect(find.byType(InkWell), findsNothing); // No thumbnails.
    });

    testWidgets('handles a single image (no thumbnails)',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(['assets/images/image1.jpg']));

      expect(find.byType(Image), findsOneWidget);
      // The thumbnail list should not be built if there's only one image.
      expect(find.byType(InkWell), findsNothing);
    });
  });
}
