import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final List<String> colorOptions;
  final String selectedColor;
  final ValueChanged<String> onColorChanged;

  const ProductInfo({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.colorOptions,
    required this.selectedColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Simple placeholder options
    const colorOptions = ['White', 'Blue', 'Black'];
    const sizeOptions = ['S', 'M', 'L', 'XL'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          price,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4d2963)),
        ),
        const SizedBox(height: 12),

        // Simple option selectors (non-functional placeholders)
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedColor,
                onChanged: (v) {
                  if (v != null) onColorChanged(v);
                },
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
        Text(description,
            style: const TextStyle(color: Colors.grey, height: 1.5)),
      ],
    );
  }
}
