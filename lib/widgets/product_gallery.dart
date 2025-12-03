import 'package:flutter/material.dart';

// Local helper to choose AssetImage for bundled paths or NetworkImage.
ImageProvider<Object> _imageProviderFor(String url) {
  if (url.startsWith('assets/')) return AssetImage(url);
  return NetworkImage(url);
}

class ProductGallery extends StatefulWidget {
  final List<String> images;

  const ProductGallery({super.key, required this.images});

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 1000;

    Widget mainImage(String url) {
      final image = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image(
          image: _imageProviderFor(url),
          fit: isDesktop ? BoxFit.contain : BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image_not_supported,
                    size: 64, color: Colors.grey),
              ),
            );
          },
        ),
      );

      if (isDesktop) return Center(child: image);
      return AspectRatio(aspectRatio: 4 / 3, child: image);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main image area
        Expanded(child: mainImage(widget.images[_selected])),

        const SizedBox(height: 12),

        // Thumbnails
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final url = widget.images[index];
              final bool selected = index == _selected;
              return GestureDetector(
                onTap: () => setState(() => _selected = index),
                child: Container(
                  width: 72,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: selected ? Colors.black : Colors.transparent,
                        width: 2),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image(
                      image: _imageProviderFor(url),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
