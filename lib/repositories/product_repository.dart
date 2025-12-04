import '../models/product.dart';

class ProductRepository {
  static final List<Product> _products = [
    const Product(
      id: 'uni-hoodie',
      title: 'Uni Hoodie',
      price: '£20.00',
      imageUrl: 'assets/images/hoddies/blue_hoddie.png',
      categories: ['clothing', 'signature'],
      hasColorVariants: true,
      hasSizeOptions: true,
      imageVariants: [
        'assets/images/hoddies/blue_hoddie.png',
        'assets/images/hoddies/white_hoddie.png',
        'assets/images/hoddies/black_hoddie.png',
      ],
    ),
    const Product(
      id: 'uni-tshirt',
      title: 'Uni T-Shirt',
      price: '£15.00',
      imageUrl: 'assets/images/tshirts/blue_tshirt.png',
      categories: ['clothing', 'signature'],
      hasColorVariants: true,
      hasSizeOptions: true,
      imageVariants: [
        'assets/images/tshirts/blue_tshirt.png',
        'assets/images/tshirts/white_tshirt.png',
        'assets/images/tshirts/black_tshirt.png',
      ],
    ),
    const Product(
      id: 'uni-baseball-cap',
      title: 'Uni Baseball Cap',
      price: '£12.00',
      imageUrl: 'assets/images/caps/blue_cap.png',
      categories: ['clothing'],
      hasColorVariants: true,
      hasSizeOptions: true,
      imageVariants: [
        'assets/images/caps/blue_cap.png',
        'assets/images/caps/white_cap.png',
        'assets/images/caps/black_cap.png',
      ],
    ),
    const Product(
      id: 'pencils',
      title: 'Pencils',
      price: '£3.50',
      imageUrl: 'assets/images/stationary/pencils.png',
      categories: ['merchandise', 'stationary'],
      hasColorVariants: false,
      hasSizeOptions: false,
    ),
    const Product(
      id: 'notebook',
      title: 'Notebook',
      price: '£5.00',
      imageUrl: 'assets/images/stationary/notebook.png',
      categories: ['merchandise', 'stationary'],
      hasColorVariants: false,
      hasSizeOptions: false,
    ),
    const Product(
      id: 'uni-beanie',
      title: 'Uni Beanie',
      price: '£18.00',
      imageUrl: 'assets/images/beanies/blue_beanie.png',
      categories: ['clothing'],
      hasColorVariants: true,
      hasSizeOptions: true,
      imageVariants: [
        'assets/images/beanies/blue_beanie.png',
        'assets/images/beanies/white_beanie.png',
        'assets/images/beanies/Black_beanie.png',
      ],
      isOnSale: true,
    ),
    const Product(
      id: 'lanyard',
      title: 'Lanyard',
      price: '£1.50',
      imageUrl: 'assets/images/misc/lanyard.png',
      categories: ['signature'],
      hasColorVariants: false,
      hasSizeOptions: false,
    ),
    const Product(
      id: 'bookmark',
      title: 'Bookmark',
      price: '£1.00',
      imageUrl: 'assets/images/misc/bookmark.png',
      categories: ['portsmouth'],
      hasColorVariants: false,
      hasSizeOptions: false,
    ),
    const Product(
      id: 'fridge-magnet',
      title: 'Fridge Magnet',
      price: '£2.00',
      imageUrl: 'assets/images/misc/fridge_magnet.png',
      categories: ['portsmouth'],
      hasColorVariants: false,
      hasSizeOptions: false,
    ),
    const Product(
      id: 'keychain',
      title: 'Keychain',
      price: '£2.50',
      imageUrl: 'assets/images/misc/keychain.png',
      categories: ['portsmouth'],
      hasColorVariants: false,
      hasSizeOptions: false,
      isOnSale: true,
    ),
  ];

  /// Get all products
  static List<Product> getAllProducts() {
    return List.unmodifiable(_products);
  }

  /// Get products filtered by category
  static List<Product> getProductsByCategory(String category) {
    return _products
        .where((product) => product.categories.contains(category))
        .toList();
  }

  /// Get a single product by ID
  static Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all unique categories
  static List<String> getAllCategories() {
    final categories = <String>{};
    for (var product in _products) {
      categories.addAll(product.categories);
    }
    return categories.toList()..sort();
  }

  /// Sort products by name
  static List<Product> sortByName(List<Product> products,
      {bool ascending = true}) {
    List<Product> sorted = List<Product>.from(products);
    sorted
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    if (!ascending) {
      sorted = sorted.reversed.toList();
    }
    return sorted;
  }

  /// Sort products by price
  static List<Product> sortByPrice(List<Product> products,
      {bool ascending = true}) {
    List<Product> sorted = List<Product>.from(products);
    sorted.sort((a, b) {
      final priceA =
          double.tryParse(a.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
      final priceB =
          double.tryParse(b.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
      return priceA.compareTo(priceB);
    });
    if (!ascending) {
      sorted = sorted.reversed.toList();
    }
    return sorted;
  }

  /// Search products by query string
  static List<Product> searchProducts(String query) {
    if (query.isEmpty) return [];

    final lowerQuery = query.toLowerCase().trim();

    return _products.where((product) {
      return product.title.toLowerCase().contains(lowerQuery) ||
          product.categories
              .any((cat) => cat.toLowerCase().contains(lowerQuery)) ||
          product.id.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
