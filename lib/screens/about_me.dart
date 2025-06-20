import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import '../theme_notifier.dart';
import '../navigation_provider.dart'; // ✅ Needed to switch to Projects screen

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({super.key});

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  final List<String> quotes = [
    "The best way to predict the future is to invent it.",
    "Dream big and dare to fail.",
    "Stay hungry, stay foolish.",
    "Code is like humor. When you have to explain it, it’s bad.",
    "Push yourself, because no one else is going to do it for you.",
    "Consistency is more important than perfection.",
  ];
  String currentQuote = "";
  late Timer _quoteTimer;

  void startQuoteCycle() {
    currentQuote = quotes[Random().nextInt(quotes.length)];
    _quoteTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      setState(() {
        currentQuote = quotes[Random().nextInt(quotes.length)];
      });
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    startQuoteCycle();
  }

  @override
  void dispose() {
    _quoteTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final navProvider = Provider.of<NavigationProvider>(context, listen: false);
    final isDarkMode = themeNotifier.isDarkMode;
    final backgroundColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🌞 Theme toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.light_mode, color: isDarkMode ? Colors.white54 : Colors.black),
                  Switch(
                    value: isDarkMode,
                    onChanged: themeNotifier.toggleTheme,
                  ),
                  Icon(Icons.dark_mode, color: isDarkMode ? Colors.white : Colors.black54),
                ],
              ),

              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: Center(
                  child: AnimatedTextKit(
                    key: ValueKey(textColor),
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Aryant Kumar',
                        textStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        speed: const Duration(milliseconds: 100),
                        cursor: "|",
                      ),
                    ],
                  ),
                ),
              ),

              Text(
                'Mobile App Developer',
                style: TextStyle(fontSize: 18, color: textColor),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.2),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram),
                    onPressed: () => _launchURL('https://instagram.com/raw.aryant'),
                    color: textColor,
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.github),
                    onPressed: () => _launchURL('https://github.com/AryantKumar'),
                    color: textColor,
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.linkedin),
                    onPressed: () => _launchURL('https://linkedin.com/in/aryant-kumar-dev'),
                    color: textColor,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                'Recently graduated with a degree in Computer Science. Have in-depth knowledge of native Android development and have just started working with Flutter. Currently exploring how to integrate AI into mobile apps to create smarter and more intuitive user experiences.',
                style: TextStyle(fontSize: 16, color: textColor),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.1),

              const SizedBox(height: 12),

              Text(
                '"Integrating AI into real-world mobile apps is the future."',
                style: TextStyle(
                  fontSize: 15,
                  color: isDarkMode ? Colors.indigoAccent : Colors.indigo,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 500.ms),

              const SizedBox(height: 24),

              // ✅ Projects with navigation to tab
              _buildProjectCard(
                title: 'Reposphere',
                description: 'A personal GitHub repository tracker with analytics and sync.',
                textColor: textColor,
                cardColor: backgroundColor,
                onTap: () => navProvider.setIndex(1),
              ),
              const SizedBox(height: 12),
              _buildProjectCard(
                title: 'Learnify',
                description: 'E-learning app with YouTube player, real-time notes, and in-app code editor.',
                textColor: textColor,
                cardColor: backgroundColor,
                onTap: () => navProvider.setIndex(1),
              ),

              const SizedBox(height: 24),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                child: Text(
                  '“$currentQuote”',
                  key: ValueKey(currentQuote),
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String description,
    required Color textColor,
    required Color cardColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      color: cardColor,
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        subtitle: Text(description, style: TextStyle(color: textColor)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
