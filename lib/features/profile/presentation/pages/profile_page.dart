import 'package:flutter/material.dart';
import '../../../../core/widgets/gradient_scaffold.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../data/datasources/profile_local_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../widgets/retro_sticker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final GetProfileUseCase _getProfileUseCase;
  late Future<Profile> _profileFuture;

  @override
  void initState() {
    super.initState();
    // Dependency Injection
    final dataSource = ProfileLocalDataSource();
    final repository = ProfileRepositoryImpl(dataSource: dataSource);
    _getProfileUseCase = GetProfileUseCase(repository);

    _profileFuture = _getProfileUseCase.call();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      themeColor: const Color(0xFFFFF59D),
      appBar: AppBar(
        title: const Text(
          "user_profile.exe",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
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
      body: FutureBuilder<Profile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading profile."));
          } else if (snapshot.hasData) {
            final profile = snapshot.data!;
            return SingleChildScrollView(
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
                          offset: Offset(6, 6),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Window Header
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: const BoxDecoration(
                            color: Color(0xFF6200EA),
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 2)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                profile.avatarTitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(Icons.close,
                                  color: Colors.white, size: 16),
                            ],
                          ),
                        ),
                        // Image Area
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: const Color(0xFFFFF9C4),
                          child: const Icon(Icons.face_retouching_natural,
                              size: 80, color: Colors.black),
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
                      color: const Color(0xFFF8BBD0),
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Current Mood:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                          ),
                          child: Text(
                            profile.currentMood,
                            style: const TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ------------------------------------------
                  // 3. STATS "STICKERS"
                  // ------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RetroSticker(
                        label: profile.age,
                        icon: Icons.star,
                        color: const Color(0xFFB2FF59),
                      ),
                      RetroSticker(
                        label: profile.mainTech,
                        icon: Icons.code,
                        color: const Color(0xFF40C4FF),
                      ),
                      RetroSticker(
                        label: profile.location,
                        icon: Icons.location_on,
                        color: const Color(0xFFFF80AB),
                      ),
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
                      decoration: const BoxDecoration(
                        color: Color(0xFFC0C0C0),
                        border: Border(
                          top: BorderSide(color: Colors.white, width: 2),
                          left: BorderSide(color: Colors.white, width: 2),
                          right: BorderSide(color: Colors.black, width: 2),
                          bottom: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "DOWNLOAD RESUME",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
            }
            return const SizedBox.shrink();
          },
        ),
      );
  }
}