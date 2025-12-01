import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Text(
          'About Us\n\nThis is a placeholder About page for the Union Shop demo. Replace with real content when ready.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
