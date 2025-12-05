import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/newsletter_widget.dart';

void main() {
  group('NewsletterWidget', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: Scaffold(
          body: NewsletterWidget(),
        ),
      );
    }

    testWidgets('renders title and input field', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Sign up for our newsletter'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('shows error snackbar for invalid email',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextField), 'invalid-email');
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pump(); // pump to show snackbar

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('shows success snackbar for valid email',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextField), 'test@example.com');
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pump(); // pump to show snackbar

      expect(find.text('Subscribed test@example.com to newsletter'),
          findsOneWidget);
    });

    testWidgets('clears input field after successful subscription',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextField), 'test@example.com');
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pump();

      expect(find.text('test@example.com'), findsNothing);
    });
  });
}
