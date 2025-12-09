import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});

  @override
  Future<Profile> getProfile() async {
    return await dataSource.getProfileData();
  }
}