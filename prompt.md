# Plan: Add Product Sorting to Home and Collection Pages

## Overview
Enable users to sort products by name (A-Z, Z-A) and price (low-high, high-low) on both the home page and all collection pages. Sorting should be easy to extend and maintain.

## Steps for Implementation

### 1. ✅ **COMPLETED** - Update ProductRepository
- Add static methods to return sorted product lists:
  - `List<Product> sortByName(List<Product> products, {bool ascending = true})`
  - `List<Product> sortByPrice(List<Product> products, {bool ascending = true})`

### 2. ✅ **COMPLETED** - Define Sort Options Model
- Create an enum or class for sort options:
  - Name Ascending
  - Name Descending
  - Price Ascending
  - Price Descending

### 3. Update HomeScreen and CollectionPage Widgets
- Add a dropdown or segmented control for sort selection at the top of the product grid.
- Store the selected sort option in state.
- When the sort option changes, re-sort the product list using ProductRepository methods.

### 4. Refactor Product Grid Rendering
- Ensure both pages use the sorted product list for rendering.
- Avoid code duplication by extracting grid rendering logic into a reusable widget if needed.

### 5. UI/UX Enhancements
- Make sure the sort control is clearly visible and accessible.
- Optionally, persist the last selected sort option per session.

### 6. Testing
- Verify sorting works for all product lists and categories.
- Check edge cases (e.g., products with same name or price).

## Example Sort Option Enum

```dart
enum ProductSortOption {
  nameAsc,
  nameDesc,
  priceAsc,
  priceDesc,
}
```

## Example Usage

- User selects "Price: Low to High" from dropdown.
- Product list is sorted using `ProductRepository.sortByPrice(products, ascending: true)`.
- UI updates to show sorted products.

## Benefits

- Consistent sorting experience across all product views.
- Easy to add new sort options in the future.
- Centralized sorting logic for maintainability.

## Next Steps

1. Implement sorting methods in ProductRepository.
2. Add sort controls to HomeScreen and CollectionPage.
3. Refactor grid rendering as needed.
4. Test thoroughly.