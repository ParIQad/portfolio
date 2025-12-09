import 'package:flutter/material.dart';
import '../../../../core/widgets/gradient_scaffold.dart';
import '../../domain/entities/skill_entities.dart';
import '../../domain/usecases/get_skills_usecase.dart';
import '../../data/repositories/skills_repository_impl.dart';
import '../../data/datasources/skills_local_data_source.dart';

// Widgets
import '../widgets/retro_window.dart';
import '../widgets/skill_items.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  // UseCase dependencies
  late final GetSkillsUseCase _getSkillsUseCase;
  
  // State variables
  late Future<List<HardSkill>> _hardSkillsFuture;
  late Future<List<SoftSkill>> _softSkillsFuture;
  late Future<List<LanguageSkill>> _languagesFuture;

  @override
  void initState() {
    super.initState();
    // Dependency Injection (Manually done here, usually done via GetIt/Provider)
    final dataSource = SkillsLocalDataSource();
    final repository = SkillsRepositoryImpl(dataSource: dataSource);
    _getSkillsUseCase = GetSkillsUseCase(repository);

    // Initialize data fetching
    _hardSkillsFuture = _getSkillsUseCase.executeHardSkills();
    _softSkillsFuture = _getSkillsUseCase.executeSoftSkills();
    _languagesFuture = _getSkillsUseCase.executeLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      themeColor: const Color(0xFF90CAF9),
      appBar: AppBar(
        title: const Text(
          "System_Skills.cfg",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Courier',
            fontSize: 16,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ------------------------------------------
            // 1. HARD SKILLS (Retro Loading Bars)
            // ------------------------------------------
            RetroWindow(
              title: "Hard_Skills.exe",
              icon: Icons.computer,
              child: FutureBuilder<List<HardSkill>>(
                future: _hardSkillsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                  } else if (snapshot.hasError) {
                    return const Text("Error loading drivers...");
                  } else if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!.map((skill) => 
                        HardSkillItem(label: skill.name, percentage: skill.proficiency)
                      ).toList(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            
            const SizedBox(height: 25),

            // ------------------------------------------
            // 2. SOFT SKILLS (Tags / Stickers)
            // ------------------------------------------
            RetroWindow(
              title: "Soft_Skills.txt",
              icon: Icons.favorite,
              child: FutureBuilder<List<SoftSkill>>(
                future: _softSkillsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  } else if (snapshot.hasData) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: snapshot.data!.map((skill) => 
                        SoftSkillItem(label: skill.name)
                      ).toList(),
                    );
                  }
                  return const Text("No soft skills found.");
                },
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------------------
            // 3. LANGUAGES (System Packs)
            // ------------------------------------------
            RetroWindow(
              title: "Lang_Packs.zip",
              icon: Icons.language,
              child: FutureBuilder<List<LanguageSkill>>(
                future: _languagesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                  } else if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!.map((skill) => 
                        LanguageItem(
                          language: skill.language, 
                          level: skill.proficiencyLevel, 
                          stars: skill.stars
                        )
                      ).toList(),
                    );
                  }
                  return const Text("Language pack corrupted.");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}