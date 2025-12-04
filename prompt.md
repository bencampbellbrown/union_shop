
---

# Plan: Add Shopping Cart Functionality

## Goal
Implement a shopping cart system that:
- Stores selected products with quantity and size/color options
- Displays cart items via a dedicated cart page (accessible from basket icon)
- Shows confirmation popup when items are added to cart
- Persists cart data during the session
- Displays cart item count badge on navbar
- Allows users to view, modify, and remove cart items

---

## Architecture Overview

- **CartItem Model**: Represents a product in the cart with quantity and selected options
- **CartProvider**: State management (Provider package or GetX) to manage cart data globally
- **CartPage**: Dedicated page showing all cart items, subtotal, and checkout option
- **AddToCartDialog**: Confirmation popup when adding items
- **Cart Badge**: Display item count on navbar basket icon
- **Persistent Storage** (optional): Save cart to local storage (hive/shared_preferences)

---

## Steps

### 1) Create CartItem Model
File: `lib/models/cart_item.dart`

```dart
class CartItem {
  final String productId;
  final String title;
  final String price;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;
  final String imageUrl;
  final bool isOnSale;

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
    required this.imageUrl,
    this.isOnSale = false,
  });

  /// Create a copy with modified fields
  CartItem copyWith({
    int? quantity,
    String? selectedColor,
    String? selectedSize,
  }) {
    return CartItem(
      productId: productId,
      title: title,
      price: price,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      imageUrl: imageUrl,
      isOnSale: isOnSale,
    );
  }
}
```

Why: Encapsulates cart item data with helper methods for updates.

---

### 2) Create CartProvider (State Management)
File: `lib/providers/cart_provider.dart`

Use **Provider** package (add to pubspec.yaml: `provider: ^6.0.0`)

```dart
import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  /// Add item to cart or update quantity if exists
  void addItem(CartItem cartItem) {
    final existingIndex = _items.indexWhere((item) =>
        item.productId == cartItem.productId &&
        item.selectedColor == cartItem.selectedColor &&
        item.selectedSize == cartItem.selectedSize);

    if (existingIndex >= 0) {
      // Update quantity if product with same options exists
      _items[existingIndex] =
          _items[existingIndex].copyWith(quantity: _items[existingIndex].quantity + cartItem.quantity);
    } else {
      // Add new item
      _items.add(cartItem);
    }
    notifyListeners();
  }

  /// Remove item from cart
  void removeItem(String productId) {
    _items.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  /// Update item quantity
  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
      notifyListeners();
    }
  }

  /// Clear entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// Calculate subtotal
  double getSubtotal() {
    return _items.fold(0.0, (sum, item) {
      final price = double.tryParse(item.price.replaceAll('£', '')) ?? 0.0;
      return sum + (price * item.quantity);
    });
  }
}
```

Why: Centralized cart state management, easy to notify UI of changes.

---

### 3) Create AddToCart Dialog/Popup
File: `lib/widgets/add_to_cart_dialog.dart`

Features:
- Displays product image, title, and selected options
- Shows "Added to Cart!" confirmation message
- Shows cart item count badge
- Continue Shopping or View Cart buttons
- Auto-closes after 2 seconds (optional)

Layout:
```
┌─────────────────────────────┐
│         ✓ Added to Cart!    │
│                             │
│    [Product Image]          │
│    Product Title            │
│    Color: Blue | Size: M    │
│    Qty: 1                   │
│                             │
│ [Continue Shopping] [Cart]  │
└─────────────────────────────┘
```

---

### 4) Update ProductInfo Widget
File: `lib/widgets/product_info.dart`

Modify the "Add to Cart" button to:
- Collect selected color/size from dropdowns
- Create CartItem with selections
- Call `CartProvider.addItem()`
- Show AddToCartDialog popup

```dart
onPressed: () {
  final cartItem = CartItem(
    productId: widget.productId ?? 'unknown',
    title: widget.title,
    price: widget.price,
    quantity: _quantity,
    selectedColor: _selectedColor,
    selectedSize: _selectedSize,
    imageUrl: widget.imageUrl ?? '',
    isOnSale: widget.isOnSale,
  );
  
  Provider.of<CartProvider>(context, listen: false).addItem(cartItem);
  
  showDialog(
    context: context,
    builder: (context) => AddToCartDialog(cartItem: cartItem),
  );
}
```

---

### 5) Create CartPage
File: `lib/pages/cart_page.dart`

Features:
- List of all cart items with:
  - Product image thumbnail
  - Title, color, size, price
  - Quantity selector (± buttons)
  - Remove button
- Summary section:
  - Subtotal
  - Tax/Shipping (optional)
  - Total price
- Checkout button
- Empty cart message if no items
- Continue Shopping link

Layout:
```
┌──────────────────────────────────┐
│ Shopping Cart (3 items)          │
├──────────────────────────────────┤
│ [Img] Uni Hoodie              £20 │
│       Color: Blue | Size: M       │
│       Qty: [−] 1 [+]  [Remove]   │
├──────────────────────────────────┤
│ [Img] Uni T-Shirt             £15 │
│       Color: White | Size: L      │
│       Qty: [−] 2 [+]  [Remove]   │
├──────────────────────────────────┤
│                 Subtotal:    £50  │
│                 Tax (20%):   £10  │
│                 ──────────────    │
│                 Total:       £60  │
│                                  │
│            [Checkout Button]      │
│            [Continue Shopping]    │
└──────────────────────────────────┘
```

---

### 6) Add Cart Route
File: `lib/main.dart`

Add route:
```dart
'/cart': (context) => const CartPage(),
```

---

### 7) Update SiteScaffold Navigation
File: `lib/widgets/site_scaffold.dart`

Update basket icon to:
- Navigate to `/cart` on tap
- Display item count badge (using Consumer<CartProvider>)

```dart
Stack(
  children: [
    IconButton(
      icon: const Icon(Icons.shopping_basket),
      onPressed: () => Navigator.pushNamed(context, '/cart'),
    ),
    Consumer<CartProvider>(
      builder: (context, cart, child) {
        return cart.itemCount > 0
            ? Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${cart.itemCount}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    ),
  ],
)
```

---

### 8) Wrap App with Provider
File: `lib/main.dart`

Update MaterialApp:
```dart
return MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => CartProvider()),
  ],
  child: MaterialApp(
    // ... rest of config
  ),
)
```

---

### 9) Optional: Persist Cart to Local Storage
File: `lib/services/cart_storage_service.dart`

Use `shared_preferences` or `hive`:
- Save cart items when modified
- Load cart items on app start
- Clear cart when user logs out (if auth added later)

---

### 10) Testing
- Add item to cart → dialog appears with confirmation
- Verify cart badge updates on navbar
- Navigate to cart page → all items displayed
- Modify quantities, remove items → cart updates
- Checkout button → placeholder for future payment flow

---

## Implementation Checklist

- [x] Step 1: Create CartItem model
- [x] Step 2: Create CartProvider (state management)
- [x] Step 3: Create AddToCartDialog widget
- [ ] Step 4: Update ProductInfo to add items to cart
- [ ] Step 5: Create CartPage
- [ ] Step 6: Add /cart route
- [ ] Step 7: Update SiteScaffold with basket icon and badge
- [ ] Step 8: Wrap app with Provider
- [ ] Step 9: (Optional) Add local storage persistence
- [ ] Step 10: Test cart functionality end-to-end

---

## Dependencies to Add

Update `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  # Optional for storage:
  # shared_preferences: ^2.1.0
  # hive: ^2.2.0
```

---

## Benefits

✅ Global state management with Provider  
✅ Persistent cart during session  
✅ User-friendly confirmation popups  
✅ Easy to extend (add shipping, taxes, discounts later)  
✅ Real-time cart badge updates  
✅ Scalable for future payment integration

---

## Future Enhancements

- Checkout and payment integration (Stripe, PayPal)
- Discount code/coupon system
- Save cart to user account (requires auth)
- Wish list / Save for later
- Cart recovery email (if abandonment tracking added)
- Inventory management (prevent overselling)
- Order history and tracking