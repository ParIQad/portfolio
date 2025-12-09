// Using a single file for related entities is cleaner for small apps

class HardSkill {
  final String name;
  final double proficiency; // 0.0 to 1.0

  HardSkill({required this.name, required this.proficiency});
}

class SoftSkill {
  final String name;

  SoftSkill({required this.name});
}

class LanguageSkill {
  final String language;
  final String proficiencyLevel;
  final int stars; // 1 to 5

  LanguageSkill({
    required this.language,
    required this.proficiencyLevel,
    required this.stars,
  });
}