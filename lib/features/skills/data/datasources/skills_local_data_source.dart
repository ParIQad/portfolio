import '../../domain/entities/skill_entities.dart';

// Simulates a local database or a JSON file
class SkillsLocalDataSource {
  
  Future<List<HardSkill>> getHardSkills() async {
    // Simulate network/db delay
    await Future.delayed(const Duration(milliseconds: 500)); 
    return [
      HardSkill(name: "Flutter / Dart", proficiency: 0.9),
      HardSkill(name: "Firebase", proficiency: 0.8),
      HardSkill(name: "UI/UX Design", proficiency: 0.75),
      HardSkill(name: "API Integration", proficiency: 0.85),
      HardSkill(name: "Git / GitHub", proficiency: 0.8),
    ];
  }

  Future<List<SoftSkill>> getSoftSkills() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      SoftSkill(name: "Teamwork"),
      SoftSkill(name: "Problem Solving"),
      SoftSkill(name: "Creative"),
      SoftSkill(name: "Fast Learner"),
      SoftSkill(name: "Communication"),
      SoftSkill(name: "Adaptability"),
    ];
  }

  Future<List<LanguageSkill>> getLanguages() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      LanguageSkill(language: "Thai", proficiencyLevel: "Native", stars: 5),
      LanguageSkill(language: "English", proficiencyLevel: "Professional", stars: 4),
      LanguageSkill(language: "Chinese", proficiencyLevel: "Basic", stars: 2),
    ];
  }
}