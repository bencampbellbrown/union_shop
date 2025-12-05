import 'dart:async';
import 'package:flutter/material.dart';
import 'package:union_shop/models/hero_banner.dart';

class HeroBanner extends StatefulWidget {
  final List<HeroBannerItem> banners;
  final Duration autoScrollDuration;

  const HeroBanner({
    super.key,
    required this.banners,
    this.autoScrollDuration = const Duration(seconds: 5),
  });

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (widget.banners.length <= 1) return;

    _autoScrollTimer = Timer.periodic(widget.autoScrollDuration, (timer) {
      if (!_isHovering && mounted) {
        final nextPage = (_currentPage + 1) % widget.banners.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _pauseAutoScroll() {
    setState(() {
      _isHovering = true;
    });
  }

  void _resumeAutoScroll() {
    setState(() {
      _isHovering = false;
    });
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _pauseAutoScroll();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _resumeAutoScroll();
    });
  }

  void _navigateToBanner(BuildContext context, HeroBannerItem banner) {
    Navigator.pushNamed(
      context,
      banner.routeName,
      arguments: banner.routeArgs,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final bannerHeight = isDesktop ? 450.0 : 280.0;

    return MouseRegion(
      onEnter: (_) => _pauseAutoScroll(),
      onExit: (_) => _resumeAutoScroll(),
      child: SizedBox(
        height: bannerHeight,
        child: Stack(
          children: [
            // PageView for banners
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: widget.banners.length,
              itemBuilder: (context, index) {
                final banner = widget.banners[index];
                return GestureDetector(
                  key: ValueKey('banner_item_$index'),
                  onTap: () => _navigateToBanner(context, banner),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Banner image
                      Image.asset(
                        banner.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 64,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                      // Gradient overlay for text readability
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                      // Banner text
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              banner.title,
                              style: TextStyle(
                                fontSize: isDesktop ? 32 : 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            if (banner.subtitle != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                banner.subtitle!,
                                style: TextStyle(
                                  fontSize: isDesktop ? 18 : 16,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Arrow buttons (desktop only)
            if (isDesktop && widget.banners.length > 1) ...[
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      final prevPage =
                          (_currentPage - 1 + widget.banners.length) %
                              widget.banners.length;
                      _goToPage(prevPage);
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      final nextPage =
                          (_currentPage + 1) % widget.banners.length;
                      _goToPage(nextPage);
                    },
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ),
              ),
            ],

            // Dot indicators
            if (widget.banners.length > 1)
              Positioned(
                left: 0,
                right: 0,
                bottom: 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.banners.length,
                    (index) => GestureDetector(
                      key: ValueKey('banner_dot_$index'),
                      onTap: () => _goToPage(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
