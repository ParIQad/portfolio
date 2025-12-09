import 'package:flutter/material.dart';
import '../../domain/entities/project_entity.dart';

class ExperienceLocalDataSource {
  
  Future<List<Project>> getProjects() async {
    // Simulate a database fetch delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      Project(
        title: "E-Shop",
        category: "App",
        description: "A flutter shopping app with payment gateway integration, cart management, and order tracking.",
        color: Colors.blueAccent,
        icon: Icons.shopping_bag,
      ),
      Project(
        title: "Taskify",
        category: "Tool",
        description: "Productivity tool for organizing daily tasks with local storage and notifications.",
        color: Colors.teal,
        icon: Icons.check_box,
      ),
      Project(
        title: "Weather",
        category: "API",
        description: "Live weather tracking using OpenWeatherMap API with dynamic background changes.",
        color: Colors.orange,
        icon: Icons.sunny,
      ),
      Project(
        title: "ChatAI",
        category: "AI",
        description: "Chatbot interface connected to Gemini API for natural language processing.",
        color: Colors.purple,
        icon: Icons.smart_toy,
      ),
      Project(
        title: "Music",
        category: "UI",
        description: "A retro-styled music player UI concept with cassette tape animations.",
        color: Colors.pink,
        icon: Icons.music_note,
      ),
      Project(
        title: "Finance",
        category: "Data",
        description: "Personal finance tracker with charts and expense categorization.",
        color: Colors.green,
        icon: Icons.attach_money,
      ),
    ];
  }
}