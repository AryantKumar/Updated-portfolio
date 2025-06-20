import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  final List<Map<String, dynamic>> projects = const [
    {
      'name': 'Learnify User App',
      'description':
      'An E-learning app with YouTube player, notes, and code editor.',
      'github': 'https://github.com/AryantKumar/Learnify-User-App',
      'logo': 'assets/learnifyy.png',
      'screenshots': [
        'assets/learnify.jpg',
        'assets/learnify2.jpg',
      ],
      'tech': [
        {
          'logo': 'assets/Java.png',
          'name': 'Java',
          'desc': 'Used Java for Android compatibility and Firebase integration.',
        },
        {
          'logo': 'assets/firebase.png',
          'name': 'Firebase',
          'desc': 'Used for auth, Firestore & storage.',
        },
      ],
    },
    {
      'name': 'Reposphere',
      'description': 'Track GitHub repositories with analytics and sync.',
      'github': 'https://github.com/AryantKumar/RepoSphere',
      'logo': 'assets/repo.png',
      'screenshots': [
        'assets/repo1.jpg',
      ],
      'tech': [
        {
          'logo': 'assets/Kotlin.png',
          'name': 'Kotlin',
          'desc': 'Modern syntax with Android-first support.',
        },
        {
          'logo': 'assets/github.png',
          'name': 'GitHub API',
          'desc': 'Powered by GitHub REST API.',
        },
      ],
    },
  ];

  void _launchGitHub(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showProjectDetails(BuildContext context, Map<String, dynamic> project) {
    showDialog(
      context: context,
      barrierColor: Colors.black38,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: Colors.white.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (project['logo'] != null)
                  Image.asset(project['logo'], height: 60),
                const SizedBox(height: 8),
                Text(project['name'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(project['description'], textAlign: TextAlign.center),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => _launchGitHub(project['github']),
                  icon: const Icon(Icons.link),
                  label: const Text("GitHub"),
                ),
                const SizedBox(height: 16),
                if (project['screenshots'] != null)
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: project['screenshots'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              project['screenshots'][index],
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 16),
                if (project['tech'] != null) ...[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Tech Stack Used:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(project['tech'].length, (index) {
                      final tech = project['tech'][index];
                      return ListTile(
                        leading: Image.asset(tech['logo'], width: 32),
                        title: Text(tech['name']),
                        subtitle: Text(tech['desc']),
                      );
                    }),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔤 Title
              Text("Projects",
                  style: textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold))
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: -0.3),

              const SizedBox(height: 12),

              // 🔵 Animated Divider Line
              Container(
                height: 4,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.indigo,
                ),
              ).animate().scaleX(duration: 600.ms),

              const SizedBox(height: 10),

              // ❤️ Built with Love
              Center(
                child: Text(
                  "Built with ❤️ by Aryant Kumar",
                  style: textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.indigo,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: 0.4),
              ),

              const SizedBox(height: 20),

              // 🧱 Grid of Projects
              Expanded(
                child: GridView.builder(
                  itemCount: projects.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return GestureDetector(
                      onTap: () => _showProjectDetails(context, project),
                      child: Card(
                        elevation: 4,
                        color: Colors.white.withOpacity(0.6), // 🧊 translucent
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.apps,
                                  size: 32, color: Colors.indigo),
                              const SizedBox(height: 12),
                              Text(
                                project['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(duration: 500.ms + (index * 150).ms),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
