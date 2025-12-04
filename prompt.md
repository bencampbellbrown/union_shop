# Plan: Add Scrollable Hero Banner to Home Page

## Goal
Add an auto-scrolling hero banner carousel to the home page with:
- 3 different banner sections (content to be provided later)
- Auto-scroll functionality with manual navigation controls
- Click/tap on banner navigates to relevant page
- Responsive design (adapts to mobile/desktop)
- Smooth transitions between banners

---

## Architecture Overview

- Create a reusable `HeroBanner` widget
- Support multiple banner items with image, title, and navigation route
- Auto-scroll with pause on hover (desktop) or tap (mobile)
- Manual navigation: dots indicator and arrow buttons
- Position banner above product grid on home page

---

## Steps

### 1) Create HeroBanner model
File: `lib/models/hero_banner.dart`

```dart
class HeroBannerItem {
  final String id;
  final String title;
  final String? subtitle;
  final String imageUrl;
  final String routeName;
  final Map<String, dynamic>? routeArgs;
  
  const HeroBannerItem({
    required this.id,
    required this.title,
    this.subtitle,
    required this.imageUrl,
    required this.routeName,
    this.routeArgs,
  });
}
```

Why: Structured data for each banner slide with navigation info.

---

### 2) Create HeroBanner widget
File: `lib/widgets/hero_banner.dart`

Features:
- Accepts `List<HeroBannerItem> banners`
- Auto-scroll every 5 seconds (configurable)
- PageView or CarouselSlider for slide transitions
- Dot indicators showing current slide (bottom center)
- Arrow buttons for manual navigation (optional, desktop only)
- Pause auto-scroll on hover (desktop) or when user manually swipes
- On tap/click: Navigate to `banner.routeName` with optional args
- Smooth fade/slide transitions

Layout:
```
┌────────────────────────────────────────┐
│  [←]                              [→]  │
│                                        │
│        BANNER IMAGE + TEXT             │
│                                        │
│            ● ○ ○                       │
└────────────────────────────────────────┘
```

Responsive behavior:
- Desktop: Height ~400-500px, full width with max constraint
- Mobile: Height ~250-300px, full width
- Images should cover/contain appropriately

---

### 3) Add banner data repository
File: `lib/repositories/banner_repository.dart`

```dart
class BannerRepository {
  static final List<HeroBannerItem> _banners = [
    HeroBannerItem(
      id: 'banner-1',
      title: 'Placeholder Banner 1',
      subtitle: 'Content coming soon',
      imageUrl: 'assets/images/banners/banner1.png',
      routeName: '/collection/clothing', // Example route
    ),
    HeroBannerItem(
      id: 'banner-2',
      title: 'Placeholder Banner 2',
      subtitle: 'Content coming soon',
      imageUrl: 'assets/images/banners/sale_banner.png',
      routeName: '/sale',
    ),
    HeroBannerItem(
      id: 'banner-3',
      title: 'Placeholder Banner 3',
      subtitle: 'Content coming soon',
      imageUrl: 'assets/images/banners/banner3.png',
      routeName: '/collection/signature',
    ),
  ];

  static List<HeroBannerItem> getBanners() => _banners;
}
```

Why: Centralized banner management, easy to update content later.

---

### 4) Add banner assets directory
- Create folder: `assets/images/banners/`
- Add placeholder images: `banner1.png`, `banner2.png`, `banner3.png`
- Update `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/banners/
```

Why: Organize banner images separately from product images.

---

### 5) Integrate HeroBanner into HomeScreen
File: `lib/main.dart` (HomeScreen widget)

Add banner above the product grid:
```dart
return SiteScaffold(
  child: SingleChildScrollView(
    child: Column(
      children: [
        // Hero Banner
        HeroBanner(
          banners: BannerRepository.getBanners(),
        ),
        const SizedBox(height: 32),
        
        // Sort dropdown
        Padding(/*...*/),
        
        // Product grid
        GridView.count(/*...*/),
      ],
    ),
  ),
);
```

Note: May need to adjust layout structure to allow both scrolling and fixed grid.

---

### 6) Styling and UX polish
- Banner images: Use `BoxFit.cover` with gradient overlay for text readability
- Text styling: Bold title (24-32px), lighter subtitle (16-18px), white/contrast color
- Dot indicators: Active dot primary color, inactive dots grey with opacity
- Arrow buttons: Icon buttons with semi-transparent background (desktop only)
- Transitions: 300ms duration with `Curves.easeInOut`
- Accessibility: Semantic labels for screen readers, keyboard navigation support

---

### 7) Auto-scroll configuration
- Default interval: 5 seconds
- Pause on:
  - Hover (desktop)
  - Manual swipe/navigation
  - Focus (accessibility)
- Resume after 2 seconds of inactivity
- Loop infinitely (slide 3 → slide 1)

---

### 8) Mobile optimizations
- Touch-friendly: Large tap target for entire banner
- Swipe gestures: Native PageView swipe support
- Reduced height: 250-300px vs desktop 400-500px
- Hide arrow buttons on mobile (rely on swipe + dots)

---

## Implementation Checklist

- [x] Step 1: Create `HeroBannerItem` model
- [x] Step 2: Build `HeroBanner` widget with auto-scroll
- [x] Step 3: Create `BannerRepository` with placeholder data
- [x] Step 4: Add banner assets and update pubspec.yaml
- [x] Step 5: Integrate `HeroBanner` into HomeScreen
- [x] Step 6: Style and polish (text, dots, arrows, transitions)
- [x] Step 7: Implement auto-scroll with pause logic
- [x] Step 8: Test and optimize for mobile

---

## Testing Plan

- Auto-scroll: Verify banners auto-advance every 5 seconds
- Manual navigation: Click dots/arrows to change slides
- Pause behavior: Hover (desktop) or swipe should pause auto-scroll
- Click navigation: Tap banner navigates to correct route
- Responsive: Check banner height/layout on mobile and desktop
- Accessibility: Screen reader announces slide changes, keyboard nav works
- Edge cases: Single banner, zero banners (shouldn't crash)

---

## Future Enhancements

- Admin panel to update banners without code changes
- A/B testing different banner content
- Video backgrounds for banners
- Parallax scroll effects
- Analytics tracking (banner clicks, impressions)
- Multiple banner sets (seasonal, promotional)

---

## Dependencies (Optional)

Consider using a carousel package for easier implementation:
- `carousel_slider: ^4.2.1` - Popular, feature-rich
- `flutter_carousel_widget: ^2.0.0` - Modern alternative

Or implement with native `PageView` + `Timer` for zero dependencies.

---

## Notes

- Keep banner images optimized (WebP format, ~1920x500px max for desktop)
- Use placeholder content initially; real images/text will be provided
- Ensure banner links are tested before launch
- Consider loading banners from remote config for dynamic updates
- Auto-scroll should be smooth and not jarring