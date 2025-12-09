import 'package:flutter/material.dart';
import '../../../../core/widgets/gradient_scaffold.dart';
import '../../../../core/utils/app_utils.dart';
import '../manager/controller_manager.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/social_button.dart';
import '../widgets/message_input_area.dart';
import '../widgets/contact_status_card.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // Instance of our Logic Controller
  final ContactController _controller = ContactController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder rebuilds the UI whenever _controller calls notifyListeners()
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        return GradientScaffold(
          themeColor: const Color(0xFFD1C4E9),
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 16,
            title: const Text(
              "Instant_Messenger ~ [Online]",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier',
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 50,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: const Icon(Icons.chevron_left, color: Colors.black, size: 24),
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  shape: BoxShape.circle,
                  color: Colors.greenAccent,
                ),
                child: const Icon(Icons.wifi, size: 20, color: Colors.black),
              ),
            ],
          ),
          body: Column(
            children: [
              // --- TOP SECTION ---
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                color: Colors.white.withOpacity(0.3),
                child: Column(
                  children: [
                    const ContactStatusCard(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SocialButton(
                          icon: Icons.email,
                          label: "Email",
                          color: Colors.pinkAccent,
                          onTap: () => AppUtils.copyToClipboard(context, "parichad.w@kkumail.com"),
                        ),
                        SocialButton(
                          icon: Icons.code,
                          label: "GitHub",
                          color: Colors.black,
                          onTap: () => AppUtils.launchURL("https://github.com"),
                        ),
                        SocialButton(
                          icon: Icons.work,
                          label: "LinkedIn",
                          color: Colors.blue[700]!,
                          onTap: () => AppUtils.launchURL("https://www.linkedin.com"),
                        ),
                        SocialButton(
                          icon: Icons.phone,
                          label: "Phone",
                          color: Colors.green,
                          onTap: () => AppUtils.copyToClipboard(context, "+66 97 358 3442"),
                        ),
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Today",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ),
              ),

              // --- CHAT LIST ---
              Expanded(
                child: ListView.builder(
                  controller: _controller.scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = _controller.messages[index];
                    return ChatBubble(message: msg);
                  },
                ),
              ),

              // --- BOTTOM INPUT ---
              MessageInputArea(
                controller: _controller.textController,
                isSending: _controller.isSending,
                onSend: () =>   _controller.sendMessage(context),
              ),
            ],
          ),
        );
      },
    );
  }
}