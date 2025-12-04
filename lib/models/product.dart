import '../utils/money.dart';

class Product {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final List<String> categories;
  final bool hasColorVariants;
  final bool hasSizeOptions;
  final List<String>? imageVariants;
  final bool isOnSale;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.categories,
    this.hasColorVariants = false,
    this.hasSizeOptions = true,
    this.imageVariants,
    this.isOnSale = false,
  });

  /// Helper to get all image URLs (primary + variants)
  List<String> getAllImages() {
    if (imageVariants != null && imageVariants!.isNotEmpty) {
      return imageVariants!;
    }
    return [imageUrl];
  }

  // Computed pricing helpers
  int get pricePence => MoneyUtils.parsePriceToPence(price);

  int get salePricePence => isOnSale
      ? MoneyUtils.calcDiscountedPence(pricePence, discountPercent: 20)
      : pricePence;

  String get formattedPrice => MoneyUtils.formatPenceToPrice(pricePence);

  String get formattedSalePrice =>
      MoneyUtils.formatPenceToPrice(salePricePence);
}

/// Sorting options for products
enum ProductSortOption {
  nameAsc,
  nameDesc,
  priceAsc,
  priceDesc,
}
