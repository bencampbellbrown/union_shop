import 'package:flutter/material.dart';

class NewsletterWidget extends StatefulWidget {
  final double? maxWidth;
  const NewsletterWidget({super.key, this.maxWidth});

  @override
  State<NewsletterWidget> createState() => _NewsletterWidgetState();
}

class _NewsletterWidgetState extends State<NewsletterWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isValidEmail(String s) {
    return RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+").hasMatch(s);
  }

  void _subscribe() {
    final email = _controller.text.trim();
    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid email address'),
        backgroundColor: Colors.redAccent,
      ));
      return;
    }

    // For now, mock the subscribe action with a SnackBar confirmation.
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Subscribed $email to newsletter'),
      backgroundColor: Colors.green[700],
    ));

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Email address',
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _subscribe,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              'SUBSCRIBE',
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1),
            ),
          ),
        ),
      ],
    );

    if (widget.maxWidth != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: widget.maxWidth!),
        child: content,
      );
    }
    return content;
  }
}
