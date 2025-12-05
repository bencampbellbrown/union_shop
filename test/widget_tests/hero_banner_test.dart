import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/hero_banner.dart' as banner_model;
import 'package:union_shop/widgets/hero_banner.dart';

void main() {
  group('HeroBanner', () {
    late List<banner_model.HeroBannerItem> testBanners;

    setUp(() {
      testBanners = [
        const banner_model.HeroBannerItem(
          id: '1',
          title: 'Banner 1 Title',
          subtitle: 'Banner 1 Subtitle',
          imageUrl: 'assets/images/banner1.jpg',
          routeName: '/banner1',
        ),
        const banner_model.HeroBannerItem(
          id: '2',
          title: 'Banner 2 Title',
          subtitle: 'Banner 2 Subtitle',
          imageUrl: 'assets/images/banner2.jpg',
          routeName: '/banner2',
        ),
      ];
    });

    Widget createTestWidget(List<banner_model.HeroBannerItem> banners) {
      return MaterialApp(
        routes: {
          '/banner1': (context) => const Scaffold(body: Text('Banner 1 Page')),
          '/banner2': (context) => const Scaffold(body: Text('Banner 2 Page')),
        },
        home: Scaffold(
          body: HeroBanner(banners: banners),
        ),
      );
    }

    testWidgets('renders initial banner correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testBanners));

      expect(find.text('Banner 1 Title'), findsOneWidget);
      expect(find.text('Banner 1 Subtitle'), findsOneWidget);
    });

    testWidgets('auto-scrolls to the next banner', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testBanners));

      // Initial banner is displayed
      expect(find.text('Banner 1 Title'), findsOneWidget);
      expect(find.text('Banner 2 Title'), findsNothing);

      // Fast-forward the timer to trigger auto-scroll
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      // Second banner should now be visible
      expect(find.text('Banner 1 Title'), findsNothing);
      expect(find.text('Banner 2 Title'), findsOneWidget);
    });

    testWidgets('tapping banner navigates to correct route',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testBanners));

      await tester.tap(find.byKey(const ValueKey('banner_item_0')));
      await tester.pumpAndSettle();

      expect(find.text('Banner 1 Page'), findsOneWidget);
    });

    testWidgets('renders navigation dots and they are interactive',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testBanners));

      // Expect two dots for two banners
      expect(find.byKey(const ValueKey('banner_dot_0')), findsOneWidget);
      expect(find.byKey(const ValueKey('banner_dot_1')), findsOneWidget);

      // Tap the second dot
      await tester.tap(find.byKey(const ValueKey('banner_dot_1')));
      await tester.pumpAndSettle();

      // The second banner should be visible
      expect(find.text('Banner 2 Title'), findsOneWidget);
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('pauses auto-scroll on hover', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testBanners));

      // Simulate a hover event
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(
          location: tester.getCenter(find.byType(HeroBanner)));
      await gesture.moveTo(tester.getCenter(find.byType(HeroBanner)));
      await tester.pumpAndSettle();

      // Fast-forward time, but the banner should not scroll
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      // The first banner should still be visible
      expect(find.text('Banner 1 Title'), findsOneWidget);
      expect(find.text('Banner 2 Title'), findsNothing);
    });
  });
}
