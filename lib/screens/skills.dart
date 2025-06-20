import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  final List<Map<String, String>> skills = const [
    {'name': 'Java', 'logo': 'assets/Java.png'},
    {'name': 'Kotlin', 'logo': 'assets/Kotlin.png'},
    {'name': 'Flutter', 'logo': 'assets/flutter.png'},
    {'name': 'Firebase', 'logo': 'assets/firebase.png'},
    {'name': 'GitHub', 'logo': 'assets/github.png'},
    {'name': 'Android Studio', 'logo': 'assets/android.png'},
  ];

  final List<Map<String, String>> certifications = const [
    {
      'path': 'assets/cert1.jpg',
      'title': 'Coursera Android Development',
    },
    {
      'path': 'assets/cert2.jpg',
      'title': 'Google Play Academy',
    },

    {
      'path': 'assets/cert3.jpg',
      'title': 'AWS Cloud Practioner Certifcation from GFG',
    },
    // Add more if needed
  ];

  void _showFullScreen(BuildContext context, String imagePath, String title) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black87,
        insetPadding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 16,
              right: 16,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔤 Title
                Text(
                  'Skills',
                  style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: -0.3),

                const SizedBox(height: 20),

                // 🧠 Skills Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: skills.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final skill = skills[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(skill['logo']!, width: 50, height: 50),
                        const SizedBox(height: 8),
                        Text(skill['name']!, style: const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ).animate().fadeIn(duration: 400.ms + (index * 100).ms);
                  },
                ),

                const SizedBox(height: 32),

                // 🎓 Certifications Section
                Text(
                  'Certifications',
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ).animate().fadeIn(),

                const SizedBox(height: 12),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: certifications.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final cert = certifications[index];
                    return GestureDetector(
                      onTap: () => _showFullScreen(context, cert['path']!, cert['title']!),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              cert['path']!,
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            cert['title']!,
                            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ).animate().fadeIn(duration: 300.ms + (index * 150).ms),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
