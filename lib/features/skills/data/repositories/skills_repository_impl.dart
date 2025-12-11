import '../../domain/entities/skill_entities.dart';
import '../../domain/repositories/skills_repository.dart';
import '../datasources/skills_local_data_source.dart';

class SkillsRepositoryImpl implements SkillsRepository {
  final SkillsLocalDataSource dataSource;

  SkillsRepositoryImpl({required this.dataSource});

  @override
  Future<List<HardSkill>> getHardSkills() async {
    return await dataSource.getHardSkills();
  }

  @override
  Future<List<SoftSkill>> getSoftSkills() async {
    return await dataSource.getSoftSkills();
  }

  @override
  Future<List<LanguageSkill>> getLanguages() async {
    return await dataSource.getLanguages();
  }
}
