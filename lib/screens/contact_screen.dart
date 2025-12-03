import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/gradient_scaffold.dart';

// 1. Simple Model for Chat Messages
class ChatMessage {
  final String text;
  final bool isMe; // true = sent by user, false = received from Alex
  final String time;

  ChatMessage({required this.text, required this.isMe, required this.time});
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // 2. Dummy Chat History Data
  final List<ChatMessage> _messages = [
    ChatMessage(text: "Hey there! Thanks for checking out my portfolio. 👋", isMe: false, time: "10:00 AM"),
    ChatMessage(text: "Are you looking for a Flutter developer for your next project?", isMe: false, time: "10:01 AM"),
  ];

  Future<void> _launchURL(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      // mode: LaunchMode.externalApplication ensures it opens in the browser/LinkedIn app
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      themeColor: const Color(0xFFD1C4E9), // Pastel Lavender
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 16,
        title: const Text(
          "Instant_Messenger ~ [Online]",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Courier', fontSize: 16),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1), // The black border
              ),
              child: const Icon(
                Icons.chevron_left, // Use chevron for that specific look
                color: Colors.black, 
                size: 24
              ),
            ),
          ),
        ),
        actions: [
           // A little retro decorative button
           Container(
             margin: const EdgeInsets.only(right: 10),
             padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                shape: BoxShape.circle,
                color: Colors.greenAccent
              ),
             child: const Icon(Icons.wifi, size: 24, color: Colors.black)
           )
        ],
      ),
      // 3. Main Layout switched to Column for expanding chat area
      body: Column(
        children: [
          // --- TOP SECTION (Status & Links) ---
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            // Give it a slight background so it stands out from chat
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.3), 
            child: Column(
              children: [
                // STATUS CARD (Kept as is)
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(4, 4), blurRadius: 0)],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1C4E9),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.person, size: 30, color: Colors.white),
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Aikyu_Dev_2003", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                          Text("Status: Coding... 🎵", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 12)),
                        ],
                      ),
                      const Spacer(),
                      Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle, border: Border.all(color: Colors.black))),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // QUICK CONNECT (Kept as is)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSocialButton(Icons.email, "Email", Colors.pinkAccent, () => _copyToClipboard(context, "parichad.w@kkumail.com")),
                    _buildSocialButton(Icons.code, "GitHub", Colors.black, () => _launchURL("https://github.com")),
                    _buildSocialButton(Icons.work, "LinkedIn", Colors.blue[700]!, () => _launchURL("https://www.linkedin.com")),
                    _buildSocialButton(Icons.phone, "Phone", Colors.green, () => _copyToClipboard(context, "+66 97 358 3442")),
                  ],
                ),
              ],
            ),
          ),
          
          // --- DATE SEPARATOR ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20)
              ),
              child: const Text("Today", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
            ),
          ),

          // --- CHAT HISTORY AREA (Expands to fill space) ---
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildChatBubble(msg);
              },
            ),
          ),

          // --- BOTTOM INPUT AREA ---
          _buildInputArea(),
        ],
      ),
    );
  }

  // 4. Widget for individual chat bubbles
  Widget _buildChatBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
             mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // If not me, show small avatar
              if(!message.isMe) ...[
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
                    color: message.isMe ? const Color(0xFFD1C4E9) : Colors.white, 
                    // Retro border and shadow
                    border: Border.all(color: Colors.black, width: 1.5),
                    boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(2, 2), blurRadius: 0)],
                    // Round corners differently based on sender
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: message.isMe ? const Radius.circular(16) : const Radius.circular(4),
                      bottomRight: message.isMe ? const Radius.circular(4) : const Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.3, color: Colors.black),
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
              style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // 5. Widget for the bottom input field
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 30), // Extra bottom padding for iOS
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black, width: 2)),
      ),
      child: Row(
        children: [
          // A retro "plus" button
          Container(
            padding: const EdgeInsets.all(8),
             decoration: BoxDecoration(
               border: Border.all(color: Colors.black),
               shape: BoxShape.circle,
               color: Colors.grey[200]
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
                controller: _messageController,
                style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10)
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Send Button
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
               padding: const EdgeInsets.all(10),
               decoration: BoxDecoration(
                 color: const Color(0xFFD1C4E9), // Theme color
                 border: Border.all(color: Colors.black),
                 shape: BoxShape.circle,
                 boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(2,2), blurRadius: 0)]
               ),
              child: const Icon(Icons.send_rounded, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: _messageController.text,
          isMe: true,
          time: "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2,'0')}"
        ));
        _messageController.clear();
      });
      // Scroll to bottom after sending
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  // Helper for social buttons (kept from before)
  Widget _buildSocialButton(IconData icon, String label, Color color, VoidCallback onTap) {
     return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black), shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 0)]),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black)),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied '$text' to clipboard!"), duration: const Duration(seconds: 1)));
  }
}
