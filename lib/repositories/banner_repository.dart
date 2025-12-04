import 'package:union_shop/models/hero_banner.dart';

class BannerRepository {
  static final List<HeroBannerItem> _banners = [
    const HeroBannerItem(
      id: 'banner-1',
      title: 'Placeholder Banner 1',
      subtitle: 'Content coming soon',
      imageUrl: 'assets/images/banners/banner1.png',
      routeName: '/collection/clothing',
    ),
    const HeroBannerItem(
      id: 'banner-2',
      title: 'Placeholder Banner 2',
      subtitle: 'Content coming soon',
      imageUrl: 'assets/images/banners/banner2.png',
      routeName: '/sale',
    ),
    const HeroBannerItem(
      id: 'banner-3',
      title: 'Placeholder Banner 3',
      subtitle: 'Content coming soon',
      imageUrl: 'assets/images/banners/banner3.png',
      routeName: '/collection/signature',
    ),
  ];

  static List<HeroBannerItem> getBanners() => List.unmodifiable(_banners);
}
