# Plan: Add Sale Page to Union Shop

## Overview
Create a dedicated Sale page that displays products marked as "on sale." The page should support sorting and reuse existing grid and card components. Products can be added to the sale by updating their data in the repository.

## Steps for Implementation

### 1. ✅ **COMPLETED** - Update Product Model
- Add a `bool isOnSale` field to the `Product` class (default: `false`).

### 2. ✅ **COMPLETED** - Tag Sale Products
- In `ProductRepository`, set `isOnSale: true` for products you want to appear on the Sale page.

### 3. ✅ **COMPLETED** - Create SalePage Widget
- Create `lib/pages/sale_page.dart`.
- Use a similar structure to `CollectionPage`.
- Filter products using `ProductRepository.getAllProducts().where((p) => p.isOnSale)`.

### 4. Add Sorting to SalePage
- Add a dropdown for sorting (by name and price).
- Use the same sort logic as HomeScreen and CollectionPage.

### 5. Add Route for Sale Page
- In `main.dart`, add a route:  
  `'/sale': (context) => const SalePage(),`

### 6. Add Navigation Link
- Update the navigation bar (e.g., in `site_scaffold.dart`) to include a "Sale" link that navigates to `/sale`.

### 7. Test Sale Page
- Verify that only products with `isOnSale: true` appear.
- Check sorting and grid layout.

## Benefits

- Easy to manage sale products by toggling a single field.
- Consistent UI/UX with other product pages.
- Sorting and filtering logic is reused.

## Next Steps

1. Update Product model and repository.
2. Build SalePage widget.
3. Add navigation and routing.
4. Test thoroughly.