import '../entities/skill_entities.dart';
import '../repositories/skills_repository.dart';

class GetSkillsUseCase {
  final SkillsRepository repository;

  GetSkillsUseCase(this.repository);

  // We can fetch them individually or all together. 
  // For this page, we likely load them all at once.
  
  Future<List<HardSkill>> executeHardSkills() async {
    return await repository.getHardSkills();
  }

  Future<List<SoftSkill>> executeSoftSkills() async {
    return await repository.getSoftSkills();
  }

  Future<List<LanguageSkill>> executeLanguages() async {
    return await repository.getLanguages();
  }
}