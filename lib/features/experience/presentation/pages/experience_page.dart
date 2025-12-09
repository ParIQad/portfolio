import 'package:flutter/material.dart';
import '../../../../core/widgets/gradient_scaffold.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../data/datasources/experience_local_data_source.dart';
import '../../data/repositories/experience_repository_impl.dart';
import '../widgets/retro_project_card.dart';
import 'project_detail_page.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  late final GetProjectsUseCase _getProjectsUseCase;
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    // Dependency Injection
    final dataSource = ExperienceLocalDataSource();
    final repository = ExperienceRepositoryImpl(dataSource: dataSource);
    _getProjectsUseCase = GetProjectsUseCase(repository);

    _projectsFuture = _getProjectsUseCase.call();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      themeColor: const Color(0xFFA5D6A7), 
      appBar: AppBar(
        title: const Text(
          "experience_works.exe",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black, 
            fontWeight: FontWeight.bold, 
            fontFamily: 'Courier'
          ),
        ),
        centerTitle: false,
        titleSpacing: 16,
        backgroundColor: Colors.transparent,
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
      body: FutureBuilder<List<Project>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading projects."));
          } else if (snapshot.hasData) {
            final projects = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return RetroProjectCard(
                        project: project,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => 
                                ProjectDetailScreen(project: project),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}