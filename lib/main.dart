import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/about_me.dart';
import 'screens/projects.dart';
import 'screens/skills.dart';
import 'screens/photography.dart';
import 'screens/contact.dart';
import 'screens/splash_screen.dart';
import 'theme_notifier.dart';
import 'navigation_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'My Portfolio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: themeNotifier.currentTheme,
          home: const SplashScreen(), // This navigates to PortfolioHome after splash
        );
      },
    );
  }
}

class PortfolioHome extends StatelessWidget {
  const PortfolioHome({super.key});

  final List<Widget> screens = const [
    AboutMeScreen(),
    ProjectsScreen(),
    SkillsScreen(),
    PhotographyScreen(),
    ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screens[navigationProvider.currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.currentIndex,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => navigationProvider.setIndex(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Skills'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Photos'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Contact'),
        ],
      ),
    );
  }
}
