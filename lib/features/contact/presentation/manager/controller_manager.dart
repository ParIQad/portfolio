import 'package:flutter/material.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../data/repositories/contact_repository_impl.dart';
import '../../data/datasources/contact_remote_data_source.dart';

class ContactController extends ChangeNotifier {
  // Dependencies
  late final SendMessageUseCase _sendMessageUseCase;

  // Controllers
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // State
  bool isSending = false;
  final List<ChatMessage> messages = [
    ChatMessage(
      text: "Hey there! Thanks for checking out my portfolio. 👋",
      isMe: false,
      time: "01:27",
    ),
    ChatMessage(
      text: "Are you looking for a Flutter developer for your next project?",
      isMe: false,
      time: "01:27",
    ),
  ];

  ContactController() {
    // Initialize Dependencies (In a larger app, pass this in constructor)
    final dataSource = ContactRemoteDataSource();
    final repository = ContactRepositoryImpl(dataSource: dataSource);
    _sendMessageUseCase = SendMessageUseCase(repository);
  }

  // ---------------------------------------------------------------------------
  // THE CLEAN _sendMessage LOGIC
  // ---------------------------------------------------------------------------
  Future<void> sendMessage(BuildContext context) async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    // 1. Update State to Loading
    _setLoading(true);

    // 2. Execute Business Logic
    final success = await _sendMessageUseCase.call(text);

    // 3. Update State to Finished
    _setLoading(false);

    // 4. Handle Result
    if (success) {
      _handleSuccess(text);
    } else {
      if (context.mounted) {
        _handleFailure(context);
      }
    }
  }

  // --- Helper Methods to keep main logic clean ---

  void _setLoading(bool value) {
    isSending = value;
    notifyListeners(); // Updates the UI
  }

  void _handleSuccess(String text) {
    // Add new message
    messages.add(ChatMessage(
      text: text,
      isMe: true,
      time: "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
    ));
    
    // Clear Input
    textController.clear();
    notifyListeners();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Failed to send message. Please try again."),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}