import 'package:flutter/material.dart';
import 'package:union_shop/widgets/price_tag.dart';

class ProductInfo extends StatefulWidget {
  final String title;
  final String price;
  final String description;
  final bool showOptions;
  final bool isOnSale;

  const ProductInfo(
      {super.key,
      required this.title,
      required this.price,
      required this.description,
      this.showOptions = true,
      this.isOnSale = false});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  // Quantity selector state
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    // Simple placeholder options
    const colorOptions = ['White', 'Blue', 'Black'];
    const sizeOptions = ['S', 'M', 'L', 'XL'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        PriceTag(
          priceText: widget.price,
          isOnSale: widget.isOnSale,
          discountPercent: 20,
        ),
        const SizedBox(height: 12),

        // Simple option selectors (non-functional placeholders)
        if (widget.showOptions)
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: colorOptions[0],
                  onChanged: (_) {},
                  items: colorOptions
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  decoration: const InputDecoration(labelText: 'Colour'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: sizeOptions[1],
                  onChanged: (_) {},
                  items: sizeOptions
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  decoration: const InputDecoration(labelText: 'Size'),
                ),
              ),
            ],
          ),

        if (widget.showOptions) const SizedBox(height: 12),

        // Quantity selector (1-5)
        DropdownButtonFormField<int>(
          value: _quantity,
          decoration: const InputDecoration(labelText: 'Quantity'),
          onChanged: (v) {
            if (v == null) return;
            setState(() {
              _quantity = v;
            });
          },
          items: List.generate(5, (i) => i + 1)
              .map((n) => DropdownMenuItem(value: n, child: Text('$n')))
              .toList(),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            OutlinedButton(
              onPressed: () {}, // no-op placeholder
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                child: Text('ADD TO CART'),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {}, // no-op placeholder
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963)),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                child: Text('BUY WITH SHOP'),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),
        TextButton(onPressed: () {}, child: const Text('More payment options')),

        const SizedBox(height: 16),
        const Text('Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text(widget.description,
            style: const TextStyle(color: Colors.grey, height: 1.5)),
      ],
    );
  }
}
