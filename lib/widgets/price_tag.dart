import 'package:flutter/material.dart';
import 'package:union_shop/utils/money.dart';

class PriceTag extends StatelessWidget {
  final String priceText;
  final bool isOnSale;
  final int? basePricePence;
  final int discountPercent;

  const PriceTag({
    super.key,
    required this.priceText,
    this.isOnSale = false,
    this.basePricePence,
    this.discountPercent = 20,
  });

  @override
  Widget build(BuildContext context) {
    final int pence = basePricePence ?? MoneyUtils.parsePriceToPence(priceText);
    final int salePence = isOnSale
        ? MoneyUtils.calcDiscountedPence(pence,
            discountPercent: discountPercent)
        : pence;

    final String formatted = MoneyUtils.formatPenceToPrice(pence);
    final String formattedSale = MoneyUtils.formatPenceToPrice(salePence);

    if (!isOnSale) {
      return Text(
        formatted,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[700],
            ),
      );
    }

    final Color? muted =
        Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatted,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: muted ?? Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
        ),
        const SizedBox(width: 8),
        Text(
          formattedSale,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
