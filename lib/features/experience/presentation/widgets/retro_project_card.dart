import 'package:flutter/material.dart';
import '../../domain/entities/project_entity.dart';

class RetroProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const RetroProjectCard({
    super.key, 
    required this.project, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                // Using Hero for smooth animation
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