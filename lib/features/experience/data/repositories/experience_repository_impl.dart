import '../../domain/entities/project_entity.dart';
import '../../domain/repositories/experience_repository.dart';
import '../datasources/experience_local_data_source.dart';

class ExperienceRepositoryImpl implements ExperienceRepository {
  final ExperienceLocalDataSource dataSource;

  ExperienceRepositoryImpl({required this.dataSource});

  @override
  Future<List<Project>> getProjects() async {
    return await dataSource.getProjects();
  }
}