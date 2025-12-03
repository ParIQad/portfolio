import 'package:flutter/material.dart';
import '../widgets/gradient_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      themeColor: const Color(0xFFFFF59D), 
      
      appBar: AppBar(
        title: const Text(
          "user_profile.exe", 
          style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent, // Transparent to show gradient
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ------------------------------------------
            // 1. RETRO "AVATAR WINDOW"
            // ------------------------------------------
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(6, 6), // Hard shadow
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Window Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF6200EA), // Deep Purple (Retro Header)
                      border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("My_Avatar.jpg", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Icon(Icons.close, color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                  // Image Area
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: const Color(0xFFFFF9C4), // Pastel Yellow inside
                    child: const Icon(Icons.face_retouching_natural, size: 80, color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ------------------------------------------
            // 2. "NOTEPAD" BIO SECTION
            // ------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF8BBD0), // Pastel Pink
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(15), 
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Mood:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Text(
                      "Coding some cool Flutter widgets while listening to k-pop. 🎧✨ \n\nGoal: Build the ultimate retro portfolio app!",
                      style: TextStyle(fontFamily: 'Courier', fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ------------------------------------------
            // 3. STATS "STICKERS"
            // ------------------------------------------
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RetroSticker(label: "Age 22", icon: Icons.star, color: Color(0xFFB2FF59)), // Lime Green
                RetroSticker(label: "Flutter", icon: Icons.code, color: Color(0xFF40C4FF)), // Light Blue
                RetroSticker(label: "Khon Kaen", icon: Icons.location_on, color: Color(0xFFFF80AB)), // Pink
              ],
            ),
            
            const SizedBox(height: 30),

            // ------------------------------------------
            // 4. ACTION BUTTON
            // ------------------------------------------
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFC0C0C0), // Classic Windows Grey
                  border: const Border(
                    top: BorderSide(color: Colors.white, width: 2),
                    left: BorderSide(color: Colors.white, width: 2),
                    right: BorderSide(color: Colors.black, width: 2),
                    bottom: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "DOWNLOAD RESUME",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Widget for the Stickers (Kept inside profile screen as it's specific)
class RetroSticker extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const RetroSticker({super.key, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.black),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black)),
        ],
      ),
    );
  }
}