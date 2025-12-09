import '../../domain/repositories/contact_repository.dart';
import '../datasources/contact_remote_data_source.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteDataSource dataSource;

  ContactRepositoryImpl({required this.dataSource});

  @override
  Future<bool> sendMessage(String message) async {
    return await dataSource.sendMessageToApi(message);
  }
}