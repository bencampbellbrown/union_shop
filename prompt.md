# Plan: Add Reusable Collection Pages

## Overview
Create a flexible collection page system that can display filtered product categories (Clothing, Merchandise, Signature & Essential Range, Portsmouth City Collection, Graduation) by reusing a single `CollectionPage` widget with different filters.

## Architecture

### 1. Create Product Data Model
**File:** `lib/models/product.dart`
- Define `Product` class with fields:
  - `String id`
  - `String title`
  - `String price`
  - `String imageUrl`
  - `List<String> categories` (e.g., ['clothing', 'signature'])
  - `bool hasColorVariants`
  - `bool hasSizeOptions`
  - `List<String>? imageVariants` (optional, for multi-color products)

### 2. Create Product Repository
**File:** `lib/repositories/product_repository.dart`
- Convert current hardcoded products from `main.dart` into a centralized list
- Method: `List<Product> getAllProducts()`
- Method: `List<Product> getProductsByCategory(String category)`
- Method: `Product? getProductById(String id)`

### 3. Create Reusable Collection Page Widget
**File:** `lib/pages/collection_page.dart`
- Accept parameters:
  - `String collectionTitle` (e.g., "Clothing")
  - `String categoryFilter` (e.g., "clothing")
  - `String? description` (optional banner text)
- Use `SiteScaffold` for consistent layout
- Display filtered products in responsive grid (reuse grid logic from `main.dart`)
- Show collection title and optional description banner
- Reuse `ProductCard` widget for each product

### 4. Update Navigation Routes
**File:** `lib/main.dart`
- Add named routes for each collection:
  ```dart
  '/collection/clothing': (context) => CollectionPage(
        collectionTitle: 'Clothing',
        categoryFilter: 'clothing',
      ),
  '/collection/merchandise': (context) => CollectionPage(
        collectionTitle: 'Merchandise',
        categoryFilter: 'merchandise',
      ),
  '/collection/signature': (context) => CollectionPage(
        collectionTitle: 'Signature & Essential Range',
        categoryFilter: 'signature',
      ),
  '/collection/portsmouth': (context) => CollectionPage(
        collectionTitle: 'Portsmouth City Collection',
        categoryFilter: 'portsmouth',
      ),
  '/collection/graduation': (context) => CollectionPage(
        collectionTitle: 'Graduation',
        categoryFilter: 'graduation',
      ),
  ```

### 5. Update Shop Dropdown Navigation
**File:** `lib/widgets/site_scaffold.dart`
- Update `PopupMenuButton` `onSelected` callbacks (lines ~100-105, ~180-192)
- Navigate to appropriate collection routes:
  ```dart
  onSelected: (value) {
    switch (value) {
      case 'clothing':
        Navigator.pushNamed(context, '/collection/clothing');
        break;
      case 'merchandise':
        Navigator.pushNamed(context, '/collection/merchandise');
        break;
      // ... etc
    }
  }
  ```

### 6. Tag Existing Products with Categories
**File:** `lib/repositories/product_repository.dart`
- Assign categories to products:
  - Uni Hoodie: `['clothing', 'signature']`
  - Uni T-Shirt: `['clothing', 'signature']`
  - Uni Baseball Cap: `['clothing']`
  - Pencils: `['merchandise', 'stationary']`
  - Notebook: `['merchandise', 'stationary']`
  - Uni Beanie: `['clothing']`

### 7. Update Home Page to Use Repository
**File:** `lib/main.dart`
- Replace hardcoded `ProductCard` list with `ProductRepository.getAllProducts()`
- Map `Product` objects to `ProductCard` widgets
- Pass product metadata through navigation arguments

## Benefits of This Approach
✅ **Single source of truth** - All product data centralized in repository
✅ **DRY principle** - One `CollectionPage` widget serves all collections
✅ **Easy to extend** - Add new collections by adding routes and categories
✅ **Maintainable** - Update product details in one place
✅ **Type-safe** - Product model ensures consistent data structure

## Implementation Order
1. ✅ **COMPLETED** - Create `Product` model class
2. ✅ **COMPLETED** - Create `ProductRepository` with existing products
3. ✅ **COMPLETED** - Build `CollectionPage` widget
4. ✅ **COMPLETED** - Add collection routes to `MaterialApp`
5. ✅ **COMPLETED** - Update navigation in `SiteScaffold`
6. Refactor `HomeScreen` to use repository
7. Test each collection page

## Future Enhancements
- Add search/filter within collections
- Sort options (price, name, popularity)
- Breadcrumb navigation
- Collection-specific banners/promotions
- URL-based routing for web support