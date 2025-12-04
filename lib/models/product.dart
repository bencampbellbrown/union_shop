class Product {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final List<String> categories;
  final bool hasColorVariants;
  final bool hasSizeOptions;
  final List<String>? imageVariants;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.categories,
    this.hasColorVariants = false,
    this.hasSizeOptions = true,
    this.imageVariants,
  });

  /// Helper to get all image URLs (primary + variants)
  List<String> getAllImages() {
    if (imageVariants != null && imageVariants!.isNotEmpty) {
      return imageVariants!;
    }
    return [imageUrl];
  }
}

/// Sorting options for products
enum ProductSortOption {
  nameAsc,
  nameDesc,
  priceAsc,
  priceDesc,
}
