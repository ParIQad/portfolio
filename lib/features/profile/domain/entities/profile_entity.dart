class Profile {
  final String avatarTitle; // e.g., "My_Avatar.jpg"
  final String currentMood; // The detailed bio text
  final String age;
  final String mainTech;    // e.g., "Flutter"
  final String location;

  Profile({
    required this.avatarTitle,
    required this.currentMood,
    required this.age,
    required this.mainTech,
    required this.location,
  });
}