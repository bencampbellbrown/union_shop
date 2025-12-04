class MoneyUtils {
  static int parsePriceToPence(String priceText) {
    if (priceText.isEmpty) return 0;
    final cleaned = priceText.replaceAll(RegExp(r'[^0-9\.]'), '');
    if (cleaned.isEmpty) return 0;
    final value = double.tryParse(cleaned) ?? 0.0;
    return (value * 100).round();
  }

  static String formatPenceToPrice(int pence) {
    final value = pence / 100.0;
    return '£${value.toStringAsFixed(2)}';
  }

  static int calcDiscountedPence(int pence, {int discountPercent = 20}) {
    if (discountPercent <= 0) return pence;
    if (discountPercent >= 100) return 0;
    final discounted = (pence * (100 - discountPercent)) ~/ 100;
    return discounted < 0 ? 0 : discounted;
  }
}
