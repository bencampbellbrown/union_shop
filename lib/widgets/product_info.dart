import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/price_tag.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/widgets/add_to_cart_dialog.dart';

class ProductInfo extends StatefulWidget {
  final String title;
  final String price;
  final String? salePrice;
  final String description;
  final bool showOptions;
  final bool isOnSale;
  final String? productId;
  final String? imageUrl;

  const ProductInfo(
      {super.key,
      required this.title,
      required this.price,
      this.salePrice,
      required this.description,
      this.showOptions = true,
      this.isOnSale = false,
      this.productId,
      this.imageUrl});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  // Quantity selector state
  int _quantity = 1;
  String? _selectedColor;
  String? _selectedSize;

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

        // Simple option selectors
        if (widget.showOptions)
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedColor ?? colorOptions[0],
                  onChanged: (value) {
                    setState(() {
                      _selectedColor = value;
                    });
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
                  value: _selectedSize ?? sizeOptions[1],
                  onChanged: (value) {
                    setState(() {
                      _selectedSize = value;
                    });
                  },
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

        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 500;

            if (isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      final cartItem = CartItem(
                        productId: widget.productId ?? 'unknown',
                        title: widget.title,
                        price: widget.price,
                        salePrice: widget.salePrice,
                        quantity: _quantity,
                        selectedColor: _selectedColor,
                        selectedSize: _selectedSize,
                        imageUrl: widget.imageUrl ?? '',
                        isOnSale: widget.isOnSale,
                      );

                      Provider.of<CartProvider>(context, listen: false)
                          .addItem(cartItem);

                      showDialog(
                        context: context,
                        builder: (context) =>
                            AddToCartDialog(cartItem: cartItem),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('ADD TO CART'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed:
                        () {}, // placeholder for future Shop Pay integration
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('BUY WITH SHOP'),
                    ),
                  ),
                ],
              );
            } else {
              // Show side-by-side on desktop
              return Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      final cartItem = CartItem(
                        productId: widget.productId ?? 'unknown',
                        title: widget.title,
                        price: widget.price,
                        salePrice: widget.salePrice,
                        quantity: _quantity,
                        selectedColor: _selectedColor,
                        selectedSize: _selectedSize,
                        imageUrl: widget.imageUrl ?? '',
                        isOnSale: widget.isOnSale,
                      );

                      Provider.of<CartProvider>(context, listen: false)
                          .addItem(cartItem);

                      showDialog(
                        context: context,
                        builder: (context) =>
                            AddToCartDialog(cartItem: cartItem),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 18.0),
                      child: Text('ADD TO CART'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed:
                        () {}, // placeholder for future Shop Pay integration
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 18.0),
                      child: Text('BUY WITH SHOP'),
                    ),
                  ),
                ],
              );
            }
          },
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
