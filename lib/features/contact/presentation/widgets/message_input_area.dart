import 'package:flutter/material.dart';

class MessageInputArea extends StatelessWidget {
  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;

  const MessageInputArea({
    super.key,
    required this.controller,
    required this.isSending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 30), // Extra padding for safe area
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black, width: 2)),
      ),
      child: Row(
        children: [
          // A retro "plus" button (Decorative for now)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: const Icon(Icons.add, color: Colors.black, size: 20),
          ),
          const SizedBox(width: 10),
          // The Text Field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black),
              ),
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.black),
                enabled: !isSending,
                decoration: InputDecoration(
                  hintText: isSending ? "Sending..." : "Type a message...",
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Send Button
          GestureDetector(
            onTap: isSending ? null : onSend,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFD1C4E9),
                border: Border.all(color: Colors.black),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}