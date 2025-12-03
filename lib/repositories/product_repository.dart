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
}
