import 'package:flutter/material.dart';
import '../widgets/gradient_scaffold.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ------------------------------------------
            // 1. HARD SKILLS (Retro Loading Bars)
            // ------------------------------------------
            _buildRetroWindow(
              title: "Hard_Skills.exe",
              icon: Icons.computer,
              child: Column(
                children: [
                  _buildSkillBar("Flutter / Dart", 0.9),
                  _buildSkillBar("Firebase", 0.8),
                  _buildSkillBar("UI/UX Design", 0.75),
                  _buildSkillBar("API Integration", 0.85),
                  _buildSkillBar("Git / GitHub", 0.8),
                ],
              ),
            ),
            
            const SizedBox(height: 25),

            // ------------------------------------------
            // 2. SOFT SKILLS (Tags / Stickers)
            // ------------------------------------------
            _buildRetroWindow(
              title: "Soft_Skills.txt",
              icon: Icons.favorite,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildRetroTag("Teamwork"),
                  _buildRetroTag("Problem Solving"),
                  _buildRetroTag("Creative"),
                  _buildRetroTag("Fast Learner"),
                  _buildRetroTag("Communication"),
                  _buildRetroTag("Adaptability"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------------------
            // 3. LANGUAGES (System Packs)
            // ------------------------------------------
            _buildRetroWindow(
              title: "Lang_Packs.zip",
              icon: Icons.language,
              child: Column(
                children: [
                  _buildLanguageRow("Thai", "Native", 5),
                  const SizedBox(height: 10),
                  _buildLanguageRow("English", "Professional", 4),
                  const SizedBox(height: 10),
                  _buildLanguageRow("Chinese", "Basic", 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------
  // HELPER WIDGETS
  // ---------------------------------------------------

  // The main container looking like a Windows 95 window
  Widget _buildRetroWindow({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(5, 5),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Window Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
              color: Colors.black, // High contrast header
              border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Courier',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.minimize, color: Colors.white, size: 16),
                const SizedBox(width: 5),
                const Icon(Icons.close, color: Colors.white, size: 16),
              ],
            ),
          ),
          // Window Body
          Padding(
            padding: const EdgeInsets.all(15),
            child: child,
          ),
        ],
      ),
    );
  }

  // Hard Skill Bar (Looks like a progress bar)
  Widget _buildSkillBar(String label, double percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 4),
          Container(
            height: 15,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(2), // Slight roundness
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: constraints.maxWidth * percentage,
                    color: const Color(0xFF90CAF9), // Bar color matches theme
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Soft Skill Tag (Looks like a sticker)
  Widget _buildRetroTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9C4), // Pastel Yellow sticker
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(2, 2),
            blurRadius: 0,
          )
        ],
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  // Language Row (Star rating style)
  Widget _buildLanguageRow(String language, String level, int stars) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(language, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
            Text(level, style: const TextStyle(fontSize: 12, color: Colors.grey,)),
          ],
        ),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < stars ? Icons.star : Icons.star_border,
              color: Colors.black,
              size: 18,
            );
          }),
        ),
      ],
    );
  }
}