import '../entities/skill_entities.dart';

abstract class SkillsRepository {
  Future<List<HardSkill>> getHardSkills();
  Future<List<SoftSkill>> getSoftSkills();
  Future<List<LanguageSkill>> getLanguages();
}