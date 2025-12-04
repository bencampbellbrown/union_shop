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
