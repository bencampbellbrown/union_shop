# Plan: Implement Product Search with Search Results Page

## Goal
Add a search feature that allows users to search for products by title or other attributes. Display matching products on a dedicated "Search Results" page with:
- A grid of matching ProductCards
- A "No results found" message when the search yields no matches
- Sorting options (consistent with other pages)
- A clear indication of what was searched

---

## Architecture Overview

- Add a search bar to the site navigation (SiteScaffold)
- Create a SearchResultsPage that filters products based on query
- Use ProductRepository to search across product fields
- Reuse ProductCard.fromProduct for consistent display
- Support sorting on search results

---

## Steps

### 1) Add search method to ProductRepository
File: `lib/repositories/product_repository.dart`

Add:
```dart
static List<Product> searchProducts(String query) {
  if (query.isEmpty) return [];
  
  final lowerQuery = query.toLowerCase().trim();
  
  return _products.where((product) {
    return product.title.toLowerCase().contains(lowerQuery) ||
           product.categories.any((cat) => cat.toLowerCase().contains(lowerQuery)) ||
           product.id.toLowerCase().contains(lowerQuery);
  }).toList();
}
```

Why: Centralized search logic that can be extended to search description, tags, etc.

---

### 2) Create SearchResultsPage widget
File: `lib/pages/search_results_page.dart`

Props:
- `String query` (the search term)

Features:
- Uses `ProductRepository.searchProducts(query)` to get matching products
- Shows header: "Search results for '{query}'" and result count
- If empty: displays a large centered message:
  - Icon (search with X or magnifying glass)
  - "No results found for '{query}'"
  - Suggestion text: "Try different keywords"
- If not empty: responsive grid of `ProductCard.fromProduct(product)`
- Sorting dropdown (same as Home/Collection/Sale pages)
- Default sort: Name A-Z (or keep Price High-Low for consistency)

Layout:
```
┌─────────────────────────────────────┐
│ Search results for "hoodie" (3)     │
│ [Sort: Name A-Z ▼]                  │
├─────────────────────────────────────┤
│ [ProductCard] [ProductCard] [Card]  │
│ [ProductCard] [ProductCard]         │
└─────────────────────────────────────┘
```

Empty state:
```
┌─────────────────────────────────────┐
│ Search results for "xyz" (0)        │
├─────────────────────────────────────┤
│                                     │
│         🔍                          │
│   No results found for "xyz"        │
│   Try different keywords            │
│                                     │
└─────────────────────────────────────┘
```

---

### 3) Add search route
File: `lib/main.dart`

Add route:
```dart
'/search': (context) {
  final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
  final query = args?['query'] as String? ?? '';
  return SearchResultsPage(query: query);
},
```

Why: Allows navigation with query parameter.

---

### 4) Add search bar to SiteScaffold
File: `lib/widgets/site_scaffold.dart`

Add a search TextField/SearchBar in the AppBar:
- Desktop: Place search bar between logo and nav links (or in trailing actions)
- Mobile: Add search icon button that expands to search field or navigates to search page
- On submit/search button click:
  - Navigate to `/search` with `arguments: {'query': searchText}`
  - Clear the search field after navigation (optional)

Implementation options:
- **Option A**: Inline search field in AppBar (always visible on desktop)
- **Option B**: Search icon button → modal overlay or dedicated search page
- **Recommended**: Option A for desktop, icon button for mobile

Desktop AppBar layout:
```
┌──────────────────────────────────────────────────────┐
│ [Logo]  [SearchField______]  [Shop▼] [About] [SALE!] │
└──────────────────────────────────────────────────────┘
```

Mobile AppBar:
```
┌──────────────────────────────────┐
│ [☰] [Logo]              [🔍]     │
└──────────────────────────────────┘
```

---

### 5) Handle empty/whitespace queries
- If user submits empty or whitespace-only query, either:
  - Show validation message ("Please enter a search term")
  - Navigate to search page with empty results and instructional message
- Recommended: Disable search button until query has non-whitespace content

---

### 6) Styling and UX polish
- Search results header: Bold, larger font
- Result count: "(X results)" or "(No results)"
- Empty state icon: `Icons.search_off` or `Icons.info_outline`, size 64-80
- Empty state text: Larger font, muted color
- Sorting dropdown: Same styling as other pages
- Maintain consistent padding/spacing with Home/Collection pages

---

### 7) Optional enhancements (future)
- Search suggestions/autocomplete as user types
- Search history (recent searches)
- Filter search results by category
- Highlight matching text in product titles
- Search by price range
- Fuzzy matching for typos

---

## Implementation Checklist

- [x] Step 1: Add `searchProducts(String query)` to ProductRepository
- [x] Step 2: Create SearchResultsPage with grid + empty state
- [ ] Step 3: Add `/search` route to main.dart
- [ ] Step 4: Add search bar to SiteScaffold AppBar
- [ ] Step 5: Handle empty queries gracefully
- [ ] Step 6: Style and test on desktop + mobile
- [ ] Step 7: (Optional) Add enhancements

---

## Testing Plan

- Search for existing product: "hoodie" → should show Uni Hoodie
- Search for category: "clothing" → should show all clothing items
- Search for partial match: "cap" → should show Baseball Cap
- Search for non-existent term: "xyz" → should show empty state
- Search with whitespace: "  " → should handle gracefully
- Sort search results → should work consistently
- Test on desktop and mobile viewports

---

## Notes

- Keep search case-insensitive and trim whitespace
- Consider searching across title, categories, and id initially
- Can extend to search description, tags, SKU later
- Search bar should be accessible (keyboard navigation, clear button)