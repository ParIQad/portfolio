import 'package:flutter/material.dart';
import '../../../../core/widgets/gradient_scaffold.dart';
import '../../domain/entities/project.dart';
import 'project_detail_page.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  // Sample Data (You can add real images later)
  final List<Project> projects = [
    Project(
      title: "E-Shop",
      category: "App",
      description: "A flutter shopping app with payment gateway.",
      color: Colors.blueAccent,
      icon: Icons.shopping_bag,
    ),
    Project(
      title: "Taskify",
      category: "Tool",
      description: "Productivity tool for organizing daily tasks.",
      color: Colors.teal,
      icon: Icons.check_box,
    ),
    Project(
      title: "Weather",
      category: "API",
      description: "Live weather tracking using OpenWeatherMap.",
      color: Colors.orange,
      icon: Icons.sunny,
    ),
    Project(
      title: "ChatAI",
      category: "AI",
      description: "Chatbot interface connected to Gemini.",
      color: Colors.purple,
      icon: Icons.smart_toy,
    ),
     Project(
      title: "Music",
      category: "UI",
      description: "A retro music player UI concept.",
      color: Colors.pink,
      icon: Icons.music_note,
    ),
     Project(
      title: "Finance",
      category: "Data",
      description: "Personal finance tracker with charts.",
      color: Colors.green,
      icon: Icons.attach_money,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      themeColor: const Color(0xFFA5D6A7), 
      appBar: AppBar(
        title: const Text(
          "experience_works.exe",
          style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Courier'),
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
                ), // The black border
              ),
              child: const Icon(
                Icons.chevron_left, // Use chevron for that specific look
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 Columns
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: 0.85, // Taller cards to fit text below
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return _buildRetroCard(context, project);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRetroCard(BuildContext context, Project project) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailScreen(project: project),
          ),
        );
      },
      child: Column(
        children: [
          // The Image Area (Rounded Square)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(4, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Center(
                // Using Hero for smooth animation to the next page
                child: Hero(
                  tag: project.title, 
                  child: Icon(project.icon, size: 50, color: project.color),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // The Label Area
          Text(
            project.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Text(
            project.category,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}