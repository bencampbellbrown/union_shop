import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_scaffold.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.grey[700];

    Widget content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          const Center(
            child: Text(
              'About us',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Constrained content column to mimic the centered layout in the screenshot
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to the Union Shop!',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'We\'re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!',
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'All online purchases are available for delivery or instore collection!',
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us at hello@upsu.net.',
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Happy shopping!',
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'The Union Shop & Reception Team',
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return SiteScaffold(child: content);
  }
}
