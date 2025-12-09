import '../entities/project_entity.dart';
import '../repositories/experience_repository.dart';

class GetProjectsUseCase {
  final ExperienceRepository repository;

  GetProjectsUseCase(this.repository);

  Future<List<Project>> call() async {
    return await repository.getProjects();
  }
}