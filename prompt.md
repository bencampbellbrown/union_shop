# Product page redesign plan

Goal: Make `lib/product_page.dart` match the provided storefront layout — large left image gallery with thumbnails, and product info (title, price, options, actions) on the right. Responsive: stacked on narrow screens, two-column on desktop.

## Quick checklist
1. Update layout to two-column Row on wide screens, Column on small screens (use MediaQuery / LayoutBuilder).
2. Replace fixed image Container with an interactive `ProductGallery`:
   - Large main image that preserves full image (BoxFit.contain on desktop).
   - Clickable thumbnail strip beneath the main image; selecting a thumbnail updates main image.
   - Smooth image loading + errorBuilder.
3. Right column `ProductInfo`:
   - Title (large, bold) and price (purple accent).
   - "Tax included" small label.
   - Dropdowns for Color, Size, Quantity (use `DropdownButtonFormField`).
   - "Add to cart" button (outlined) and primary purple "Buy with shop" button.
   - "More payment options" link under primary button.
4. Beneath columns: product description text and smaller details (size chart links).
5. Accessibility: semantics, tooltips, and form labels.
6. Reuse `SiteScaffold` and theme colors.

## Files to change / add
- lib/product_page.dart — refactor main layout into `ProductGallery` + `ProductInfo`.
- lib/widgets/product_gallery.dart — new widget that manages selected image state.
- lib/widgets/product_info.dart — new widget for form/CTA.
- lib/main.dart — ensure image URLs can be assets or network (already present with _imageProviderFor).
- assets/images/ — add product images (already in repo). Update pubspec if needed.

## Widget structure (high level)
- ProductPage (uses SiteScaffold)
  - ResponsiveBuilder -> Row (desktop) or Column (mobile)
    - Expanded(left)
      - ProductGallery(images: [...])
    - Expanded(right)
      - ProductInfo(title, price, options, handlers)
  - Below: Description, size table, related thumbnails

## Implementation notes & important snippets

- Responsive switch:
```dart
final isDesktop = MediaQuery.of(context).size.width > 1000;
return isDesktop
  ? Row(children: [leftExpanded, SizedBox(width: 48), rightExpanded])
  : Column(children: [left, SizedBox(height:24), right]);
```

- Gallery main image (desktop: contain, mobile: cover with AspectRatio):
```dart
Widget mainImage(String url, bool isDesktop) {
  final image = Image(image: _imageProviderFor(url), fit: isDesktop ? BoxFit.contain : BoxFit.cover,);
  if (isDesktop) return Center(child: image);
  return AspectRatio(aspectRatio: 4/3, child: ClipRRect(borderRadius: BorderRadius.circular(8), child: image));
}
```

- Thumbnail strip (use `GestureDetector` or `InkWell` to change selected index).

- Product options form:
  - Use `Form` + `DropdownButtonFormField` for color/size.
  - Keep local validation minimal.

- Action buttons:
  - OutlinedButton for Add to cart:
    ```dart
    OutlinedButton(
      onPressed: {},
      child: Text('ADD TO CART'),
    )
    ```
  - ElevatedButton for primary (purple):
    ```dart
    ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4d2963)),
      onPressed: {},
      child: Text('Buy with shop'),
    )
    ```

## Visual polish
- Align title & price to the top-right vertically centered to the main image.
- Use spacing similar to screenshot: large gutters, comfortable whitespace.
- Thumbnails: fixed height (e.g., 64px) with a selected outline.
- Use `SingleChildScrollView` for content overflow on small screens.

## Testing & verification
- Manual: run app in browser/desktop and mobile widths; verify thumbnails update main image and buttons navigate or show SnackBar.
- Widget tests: add tests for `ProductGallery` to ensure thumbnail taps update display.

## Next steps I can do for you
- Generate the concrete patch for `product_page.dart` and create `product_gallery.dart` + `product_info.dart`.
- Implement thumbnails behavior and update tests.
- Add example assets to `assets/images/` and sample image list.
