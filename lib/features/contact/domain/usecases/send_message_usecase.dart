import '../repositories/contact_repository.dart';

class SendMessageUseCase {
  final ContactRepository repository;

  SendMessageUseCase(this.repository);

  Future<bool> call(String message) async {
    return await repository.sendMessage(message);
  }
}