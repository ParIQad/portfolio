import 'package:flutter/material.dart';
import 'package:portfolio/widgets/folder_tab.dart';
import '../screens/profile_screen.dart';
import '../screens/experiance_screen.dart';
import '../screens/skills_screen.dart';
import '../screens/contact_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "My Portfolio",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // The Gradient Background
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF64B5F6), // Blue Top
              Colors.white, // White Middle
              Colors.white,
              Color(0xFF64B5F6), // Blue Bottom
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ---------------------------------------------
              // 1. THE MAIN ID CARD
              // ---------------------------------------------
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ), // The bold black border
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Card Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellowAccent, // Y2K Highlight
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Text(
                            "Team Woxa",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Text(
                          "ID: 20030816",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Photo and Details Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Photo Box
                        Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Details Text
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _InfoRow(label: "Nickname", value: "Aikyu"),
                              _InfoRow(label: "Location", value: "Khon Kaen"),
                              _InfoRow(
                                label: "Role",
                                value: "Flutter Developer",
                              ),
                              SizedBox(height: 10),
                              Text(
                                "This card certifies the bearer is a Flutter expert.",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ---------------------------------------------
              // 2. THE FOLDER TABS NAVIGATION
              // ---------------------------------------------
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Folders",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // We use a Wrap or Row to display the tabs
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GridView.count(
                    crossAxisCount: 2, // 2 tabs per row
                    childAspectRatio: 1.5, // Shape of the folder tab
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      FolderTab(
                        title: "Profile",
                        icon: Icons.person,
                        color: const Color(0xFFFFF59D), // Pastel Yellow
                        onTap: () {
                          // Navigate to Profile Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                      ),
                      FolderTab(
                        title: "Experience",
                        icon: Icons.work_history,
                        color: const Color(0xFFA5D6A7), // Pastel Green
                        onTap: () {
                          // Navigate to Experience Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ExperienceScreen(),
                            ),
                          );
                        },
                      ),
                      FolderTab(
                        title: "Skills",
                        icon: Icons.bolt,
                        color: const Color(0xFF90CAF9), // Pastel Blue
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SkillsScreen(),
                            ),
                          );
                        },
                      ),
                      FolderTab(
                        title: "Contact",
                        icon: Icons.mail,
                        color: const Color(0xFFF48FB1), // Pastel Pink
                        onTap: () {
                          // Navigate to Contact Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ContactScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Keep helper widgets that are only used here private
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const Divider(height: 4, color: Colors.black12),
        ],
      ),
    );
  }
}
