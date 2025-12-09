import '../../domain/entities/profile_entity.dart';

class ProfileLocalDataSource {
  Future<Profile> getProfileData() async {
    // Simulate loading data
    await Future.delayed(const Duration(milliseconds: 600));
    
    return Profile(
      avatarTitle: "My_Avatar.jpg",
      currentMood: "Coding some cool Flutter widgets while listening to k-pop. 🎧✨ \n\nGoal: Build the ultimate retro portfolio app!",
      age: "Age 22",
      mainTech: "Flutter",
      location: "Khon Kaen",
    );
  }
}