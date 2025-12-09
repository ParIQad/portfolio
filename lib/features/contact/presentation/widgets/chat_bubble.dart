import 'package:flutter/material.dart';
import '../../domain/entities/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: message.isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: message.isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // If not me, show small avatar
              if (!message.isMe) ...[
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, size: 18, color: Colors.white),
                ),
                const SizedBox(width: 8),
              ],

              // The Bubble itself
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    // Different color for me vs other
                    color: message.isMe
                        ? const Color(0xFFD1C4E9)
                        : Colors.white,
                    // Retro border and shadow
                    border: Border.all(color: Colors.black, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        blurRadius: 0,
                      ),
                    ],
                    // Round corners differently based on sender
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: message.isMe
                          ? const Radius.circular(16)
                          : const Radius.circular(4),
                      bottomRight: message.isMe
                          ? const Radius.circular(4)
                          : const Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Time stamp below bubble
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 36, right: 8),
            child: Text(
              message.time,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}