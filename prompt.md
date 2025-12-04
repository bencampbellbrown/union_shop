# Plan: Add Collection Preview Sections to Home Page

## Goal
Display curated collection previews on the home page below the hero banner, showing:
- Collection name as a section header
- 2-3 example products from each collection
- Responsive grid layout matching existing product card styling
- Link to view full collection
- Use pre-existing collections (Clothing, Merchandise, Signature & Essential Range, Portsmouth City Collection, Graduation)

---

## Architecture Overview

- Create a reusable `CollectionPreview` widget that displays a section header and product grid
- Pass collection category filter and optional custom title
- Render 2-3 products per collection preview
- Add multiple previews to HomeScreen below the hero banner
- Maintain responsive design for mobile/desktop

---

## Steps

### 1) Create CollectionPreview Widget
File: `lib/widgets/collection_preview.dart`

Props:
- `String collectionTitle` - Display name (e.g., "Signature & Essential Range")
- `String categoryFilter` - Category to filter by (e.g., "signature")
- `int itemsToShow` - Number of products to display (default: 3)
- `bool showViewAllButton` - Show "View All" link to full collection (default: true)

Features:
- Header section with collection title and optional "View All" button
- Responsive grid (3/2/1 columns based on screen width)
- Uses `ProductCard.fromProduct()` for consistency
- Links to `/collection/{categoryFilter}` when "View All" is clicked
- Horizontal scrollable variant on mobile (optional)

Layout:
```
┌─────────────────────────────────────────────────────┐
│ Collection Title                        [View All →] │
├─────────────────────────────────────────────────────┤
│ [ProductCard] [ProductCard] [ProductCard]           │
└─────────────────────────────────────────────────────┘
```

---

### 2) Update HomeScreen Layout
File: `lib/main.dart` (HomeScreen widget)

Reorganize structure:
```dart
SingleChildScrollView(
  child: Column(
    children: [
      // 1. Hero Banner
      HeroBanner(banners: BannerRepository.getBanners()),
      
      const SizedBox(height: 48),
      
      // 2. Collection Previews
      CollectionPreview(
        collectionTitle: 'Signature & Essential Range',
        categoryFilter: 'signature',
        itemsToShow: 3,
      ),
      
      const SizedBox(height: 48),
      
      CollectionPreview(
        collectionTitle: 'Clothing',
        categoryFilter: 'clothing',
        itemsToShow: 3,
      ),
      
      const SizedBox(height: 48),
      
      CollectionPreview(
        collectionTitle: 'Merchandise',
        categoryFilter: 'merchandise',
        itemsToShow: 3,
      ),
      
      const SizedBox(height: 48),
      
      CollectionPreview(
        collectionTitle: 'Portsmouth City Collection',
        categoryFilter: 'portsmouth',
        itemsToShow: 3,
      ),
      
      const SizedBox(height: 48),
      
      CollectionPreview(
        collectionTitle: 'Graduation',
        categoryFilter: 'graduation',
        itemsToShow: 3,
      ),
      
      const SizedBox(height: 48),
    ],
  ),
)
```

Remove the old "All Products" section and sort dropdown from the home page (these can move to a dedicated "Shop All" page if needed).

---

### 3) Styling and Polish
- Section spacing: 48px vertical gap between collections
- Header styling: Bold title (24-28px), matching collection page headers
- "View All" button: Right-aligned text link with arrow icon
- Padding: Consistent with page layout (20-32px horizontal)
- Responsive: Adjust grid columns and spacing on mobile

---

### 4) Navigation
- "View All" buttons link to existing collection routes: `/collection/{categoryFilter}`
- Product cards link to product detail pages (existing behavior)

---

### 5) Optional Enhancements (Future)
- Add category icons above collection titles
- Featured product badge for one item per collection
- "New" or "Popular" labels on products
- Dynamic collection order based on sales/popularity
- Promotional banners within collection previews

---

## Implementation Checklist

- [ ] Step 1: Create `CollectionPreview` widget
- [ ] Step 2: Update HomeScreen with collection previews
- [ ] Step 3: Style and polish sections
- [ ] Step 4: Verify navigation and linking
- [ ] Step 5: Test responsive design on mobile/tablet/desktop

---

## Testing Plan

- Verify all collection previews display correctly
- Check responsive grid on different screen sizes
- Click "View All" buttons → should navigate to full collection page
- Click product cards → should navigate to product detail page
- Test on mobile and desktop viewports
- Verify spacing and alignment match design reference

---

## Benefits

- Showcases variety of products to users on home page
- Easier navigation to product categories
- Reduces scrolling burden (users see curated selection)
- Consistent reusable component (CollectionPreview)
- Scalable (easy to add/remove collection sections)