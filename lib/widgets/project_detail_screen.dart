import 'package:flutter/material.dart';
import '../models/project.dart'; // Import model เข้ามาใช้

class ProjectDetailScreen extends StatelessWidget {
  // รับค่า Argument ผ่าน Constructor
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(project.title),
              background: Container(
                // ignore: deprecated_member_use
                color: project.color.withOpacity(0.2),
                child: Center(
                  child: Hero(
                    tag: project.title, // Tag ต้องตรงกันกับหน้า Home เพื่อทำ Animation
                    child: Icon(
                      project.icon,
                      size: 80,
                      color: project.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge หมวดหมู่
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: project.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      // ignore: deprecated_member_use
                      border: Border.all(color: project.color.withOpacity(0.5)),
                    ),
                    child: Text(
                      project.category,
                      style: TextStyle(
                        color: project.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "เกี่ยวกับโปรเจกต์",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    project.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  
                  // ปุ่มย้อนกลับ
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context); // คำสั่งสำหรับย้อนกลับ
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("กลับไปหน้าหลัก"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}