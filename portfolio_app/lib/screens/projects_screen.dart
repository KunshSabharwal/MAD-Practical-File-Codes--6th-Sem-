import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/glass_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  Future<void> openRepo(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          /// PROJECT 1
          GlassCard(
            child: ListTile(
              leading: const Icon(Icons.psychology_outlined),
              title: const Text(
                "Harmful Brain Activity Detection",
              ),
              subtitle: const Text(
                "Deep learning model for EEG image-based brain activity classification.",
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => openRepo(
                "https://github.com/KunshSabharwal/Harmful-Brain-Activity-using-Deep-Learning-on-EEG-Images",
              ),
            ),
          ),

          const SizedBox(height: 18),

          /// PROJECT 2
          GlassCard(
            child: ListTile(
              leading: const Icon(Icons.insights_outlined),
              title: const Text(
                "Explainable AI on Mental Health Dataset",
              ),
              subtitle: const Text(
                "Applied SHAP and LIME techniques for interpretable machine learning analysis.",
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => openRepo(
                "https://github.com/KunshSabharwal/Explainable-AI-XAI-on-Mental-Health-Dataset",
              ),
            ),
          ),

          const SizedBox(height: 18),

          /// PROJECT 3
          GlassCard(
            child: ListTile(
              leading: const Icon(Icons.auto_awesome_outlined),
              title: const Text(
                "ExamEcho – GenAI Learning Assistant",
              ),
              subtitle: const Text(
                "Python + Generative AI project built during Winter School program.",
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => openRepo(
                "https://github.com/KunshSabharwal/Winter-School-Python-with-Gen-AI_Project_ExamEcho",
              ),
            ),
          ),

          const SizedBox(height: 18),

          /// PROJECT 4
          GlassCard(
            child: ListTile(
              leading: const Icon(Icons.mobile_friendly_outlined),
              title: const Text(
                "VIPS Veritas App",
              ),
              subtitle: const Text(
                "Flutter-based student feedback application with modern UI design.",
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => openRepo(
                "https://github.com/KunshSabharwal/VIPS-Veritas-App",
              ),
            ),
          ),

          const SizedBox(height: 18),

          /// PROJECT 5
          GlassCard(
            child: ListTile(
              leading: const Icon(Icons.lightbulb_outline),
              title: const Text(
                "Dwelp – Smart India Hackathon Project",
              ),
              subtitle: const Text(
                "Innovation-focused solution developed for Smart India Hackathon.",
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => openRepo(
                "https://github.com/KunshSabharwal/Dwelp-Project-for-SIH",
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
