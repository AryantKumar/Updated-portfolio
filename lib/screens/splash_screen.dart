import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../main.dart'; // ✅ Make sure this points to where PortfolioHome is

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PortfolioHome()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            totalRepeatCount: 1,
            animatedTexts: [
              TypewriterAnimatedText(
                'Aryant Kumar',
                speed: const Duration(milliseconds: 120),
                cursor: '|',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
