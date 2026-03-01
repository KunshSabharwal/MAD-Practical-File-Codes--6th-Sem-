import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/glass_card.dart';

class LinksScreen extends StatelessWidget {
  const LinksScreen({super.key});

  Future<void> open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> callPhone() async {
    final uri = Uri.parse("tel:+919990159801");
    await launchUrl(uri);
  }

  Future<void> sendEmail() async {
    final uri = Uri.parse("mailto:sabharwalkunsh05@gmail.com");
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect With Me"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          /// GITHUB
          GlassCard(
            child: ListTile(
              leading: const Icon(Icons.code),
              title: const Text("GitHub"),
              subtitle: const Text(
                "www.github.com/KunshSabharwal",
                style: TextStyle(fontSize: 13),
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => open(
                "https://www.github.com/KunshSabharwal",
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// LINKEDIN
          GlassCard(
            child: ListTile(
              leading: const Icon(Icons.work_outline),
              title: const Text("LinkedIn"),
              subtitle: const Text(
                "www.linkedin.com/in/kunshsabharwal",
                style: TextStyle(fontSize: 13),
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => open(
                "https://www.linkedin.com/in/kunshsabharwal",
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// CONTACT INFO CARD
          GlassCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: const Text("Phone"),
                  subtitle: const Text(
                    "+91 9990159801",
                    style: TextStyle(fontSize: 13.5),
                  ),
                  trailing: const Icon(Icons.call_outlined),
                  onTap: callPhone,
                ),
                const Divider(height: 20),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text("Email"),
                  subtitle: const Text(
                    "sabharwalkunsh05@gmail.com",
                    style: TextStyle(fontSize: 13.5),
                  ),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: sendEmail,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
