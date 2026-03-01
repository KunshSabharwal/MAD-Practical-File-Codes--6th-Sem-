import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../app_colors.dart';
import 'projects_screen.dart';
import 'links_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                /// PROFILE IMAGE
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.deep.withOpacity(0.12),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/profile.jpg",
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                /// NAME
                const Text(
                  "Kunsh Sabharwal",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.deep,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "B.Tech AI-ML (A)\nBatch 2023 – 2027",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 25),

                /// ACTION BUTTONS CARD
                GlassCard(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.folder_open_outlined,
                            color: AppColors.deep),
                        title: const Text("View Projects"),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProjectsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 20),
                      ListTile(
                        leading: const Icon(Icons.link_rounded,
                            color: AppColors.deep),
                        title: const Text("Connect With Me"),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LinksScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                /// ABOUT CARD
                const GlassCard(
                  child: Text(
                    "Third-year Bachelor of Technology student specializing "
                    "in Artificial Intelligence and Machine Learning at "
                    "Vivekananda Institute of Professional Studies "
                    "(Technical Campus), New Delhi, India under the aegis "
                    "of Guru Gobind Singh Indraprastha University (GGSIPU).\n\n"
                    "Passionate about the newest innovations and trends in "
                    "technology with interests in Artificial Intelligence, "
                    "Machine Learning, and Data Science.\n\n"
                    "Equipped with knowledge of C, C++, and Python along "
                    "with numerous skills including Leadership, Teamwork, "
                    "and Communication.\n\n"
                    "Enthusiastic and dedicated to mastering machine "
                    "learning algorithms, neural networks, data analysis, "
                    "and other cutting-edge technologies.\n\n"
                    "Always ready to learn something new.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// CONTACT CARD
                const GlassCard(
                  child: Column(
                    children: [
                      ListTile(
                        leading:
                            Icon(Icons.phone_outlined, color: AppColors.deep),
                        title: Text("Phone"),
                        subtitle: Text("+91 9990159801"),
                      ),
                      Divider(height: 20),
                      ListTile(
                        leading:
                            Icon(Icons.email_outlined, color: AppColors.deep),
                        title: Text("Email"),
                        subtitle: Text("sabharwalkunsh05@gmail.com"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
