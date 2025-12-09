import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color themeColor;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.themeColor = const Color(0xFF64B5F6), // Default to Blue
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Key for wallpaper effect
      appBar: appBar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              themeColor,        // Top Color
              Colors.white,      // Middle White
              Colors.white,      // Middle White
              themeColor,        // Bottom Color
            ],
            // This creates the "fade in, stay white, fade out" effect
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        // SafeArea is built-in so you don't forget it on new pages
        child: SafeArea(
          child: body,
        ),
      ),
    );
  }
}