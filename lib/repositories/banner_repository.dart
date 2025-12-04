import 'package:union_shop/models/hero_banner.dart';

class BannerRepository {
  static final List<HeroBannerItem> _banners = [
    const HeroBannerItem(
      id: 'banner-1',
      title: '',
      subtitle: '',
      imageUrl: 'assets/images/banners/clothing_banner.png',
      routeName: '/collection/clothing',
    ),
    const HeroBannerItem(
      id: 'banner-2',
      title: '20% Off Sale!',
      subtitle: 'Get it while it lasts',
      imageUrl: 'assets/images/banners/sale_banner.png',
      routeName: '/sale',
    ),
    const HeroBannerItem(
      id: 'banner-3',
      title: 'Prepare for Graduation',
      subtitle: '',
      imageUrl: 'assets/images/banners/graduation_banner.png',
      routeName: '/collection/graduation',
    ),
  ];

  static List<HeroBannerItem> getBanners() => List.unmodifiable(_banners);
}
