import 'package:flutter/material.dart';

class RetroWindow extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const RetroWindow({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(5, 5),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Window Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Courier',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.minimize, color: Colors.white, size: 16),
                const SizedBox(width: 5),
                const Icon(Icons.close, color: Colors.white, size: 16),
              ],
            ),
          ),
          // Window Body
          Padding(
            padding: const EdgeInsets.all(15),
            child: child,
          ),
        ],
      ),
    );
  }
}