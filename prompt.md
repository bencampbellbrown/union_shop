# Plan: Show Sale Pricing (strike-through old price + 20% off) on Collections and Product Pages

## Goal
When a product is on sale:
- Show the original price struck through
- Show a discounted price that is 20% lower than the listed price
- Apply consistently in:
  - Product tiles (Home and Collection pages)
  - Individual Product page (ProductInfo header area)

We will implement this with reusable utilities and a shared PriceTag widget to avoid duplication.

---

## Architecture Overview

- Keep Product.price as String for backward compatibility.
- Add reusable helpers to parse/format currency and calculate sale prices.
- Centralize the visual treatment of prices in a single widget (PriceTag) and reuse it in ProductCard and ProductInfo.

---

## Steps

### 1) ✅ COMPLETED — Add money utilities (parse/format/calc)
File: lib/utils/money.dart
- parsePriceToPence(String priceText) -> int
  - Accepts values like "£20", "£20.00", "20", "20.00"
- formatPenceToPrice(int pence) -> String
  - Outputs "£X.YY"
- calcDiscountedPence(int pence, {int discountPercent = 20}) -> int
  - Returns floor-discounted value for display (e.g., 20% off)

Why: Keeps logic consistent and unit-testable.

### 2) ✅ COMPLETED — Extend Product with computed getters
File: lib/models/product.dart
- Add computed getters that delegate to money utils (no breaking changes):
  - int get pricePence
  - int get salePricePence => isOnSale ? calcDiscountedPence(pricePence) : pricePence
  - String get formattedPrice
  - String get formattedSalePrice (only used if isOnSale)

Why: A thin convenience layer for UI widgets to consume.

### 3) ✅ COMPLETED — Create a reusable PriceTag widget
File: lib/widgets/price_tag.dart
Props:
- required String priceText
- bool isOnSale = false
- int? basePricePence (optional, overrides priceText parsing)
- int discountPercent = 20
Behavior:
- If isOnSale: renders Row with:
  - original price (TextDecoration.lineThrough, muted color)
  - discounted price (bold, accent color)
- Else: renders a single price
- Internally uses money utils for parsing/formatting if basePricePence not supplied

Why: One unified place to render prices everywhere.

### 4) ✅ COMPLETED — Update ProductCard to use PriceTag (non-breaking)
File: lib/widgets/product_card.dart
- Add a named constructor: ProductCard.fromProduct(Product product)
  - Uses product.title, product.imageUrl, and PriceTag(
      priceText: product.price,
      isOnSale: product.isOnSale,
      discountPercent: 20,
    )
- Keep existing constructor for any legacy use
- Prefer .fromProduct() in new code (Home/Collections/Sale pages)

### 5) ✅ COMPLETED — Switch Home and Collection pages to ProductCard.fromProduct
Files:
- lib/main.dart (Home grid)
- lib/pages/collection_page.dart
- lib/pages/sale_page.dart (already exists)
- Map products with ProductCard.fromProduct(product)

Why: Ensures consistent price rendering across all grids.

### 6) ✅ COMPLETED — Update ProductInfo to use PriceTag
File: lib/widgets/product_info.dart
- Replace direct price Text with PriceTag:
  PriceTag(
    priceText: widget.price,
    isOnSale: productOrArgs?.isOnSale ?? false, // depends on how ProductInfo receives data
    discountPercent: 20,
  )
Implementation options:
- If ProductInfo currently receives only title/price as strings, extend it to optionally accept a Product object OR a boolean isOnSale.
- Minimal change: pass a new bool isOnSale to ProductInfo and wire from route args.

Result:
- Added `bool isOnSale` to `ProductInfo` with default `false` and render `PriceTag`.

### 7) ✅ COMPLETED — Wire isOnSale to ProductPage
File: lib/product_page.dart
- When navigating to ProductPage, include `isOnSale` (and/or the Product) in arguments.
- Ensure ProductInfo receives `isOnSale: true/false` for the chosen product.
- If the app already uses ProductRepository.getProductById via args, pass the Product directly to ProductInfo.

Result:
- Read `isOnSale` from `ModalRoute.of(context)?.settings.arguments` and pass to `ProductInfo` in both desktop and mobile layouts.

### 8) Styling polish
- Old price color: Theme.of(context).textTheme.bodySmall?.color with opacity 0.6
- New price color: Theme.of(context).colorScheme.primary and FontWeight.w600
- Spacing between prices: SizedBox(width: 8)

### 9) Tests (optional but recommended)
- Unit tests for money.dart parsing/formatting/discount
- Golden/widget tests for PriceTag (with and without sale)
- Smoke test: Home/Collection/Sale pages render discounted prices for on-sale items

---

## Rollout Checklist
- Implement Steps 1–3 (utils + PriceTag)
- Update ProductCard (Step 4)
- Switch Home/Collection/Sale grids to fromProduct (Step 5)
- Update ProductInfo and ProductPage (Steps 6–7)
- Manual verify on:
  - Home grid shows discounted price for on-sale products
  - Collection pages show discounted price
  - Product page shows both struck-through and discounted prices
- Add tests (Step 9)

---

## Notes
- Discount is currently fixed at 20%. If you want per-product discounts later, extend Product with `int? discountPercent` and default to 20 when `isOnSale == true` and `discountPercent == null`.