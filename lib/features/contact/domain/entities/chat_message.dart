class ChatMessage {
  final String text;
  final bool isMe; // true = sent by user, false = received from system/admin
  final String time;

  ChatMessage({required this.text, required this.isMe, required this.time});
}