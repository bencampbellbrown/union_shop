import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/pages/cart_page.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/models/cart_item.dart';

void main() {
  testWidgets('CartPage should display empty cart message',
      (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: const MaterialApp(
          home: CartPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Should show empty cart message
    expect(find.text('Shopping Cart'), findsOneWidget);
    expect(find.text('Your cart is empty'), findsOneWidget);
  });

  testWidgets('CartPage should display cart items when added',
      (tester) async {
    final cartProvider = CartProvider();
    
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
        ],
        child: const MaterialApp(
          home: CartPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Add item to cart
    cartProvider.addItem(CartItem(
      productId: '1',
      title: 'Test Product',
      price: '£10.00',
      imageUrl: 'assets/images/placeholder.png',
      selectedSize: 'M',
      selectedColor: 'Red',
      quantity: 1,
    ));

    await tester.pumpAndSettle();

    // Should show the cart item
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('£10.00'), findsOneWidget);
  });
}
