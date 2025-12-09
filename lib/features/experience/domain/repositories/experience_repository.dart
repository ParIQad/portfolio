import '../entities/project_entity.dart';

abstract class ExperienceRepository {
  Future<List<Project>> getProjects();
}