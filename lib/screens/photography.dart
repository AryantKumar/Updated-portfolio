import 'package:flutter/material.dart';
import 'gallery_screen.dart';

class PhotographyScreen extends StatelessWidget {
  const PhotographyScreen({super.key});

  final Map<String, List<String>> photoSections = const {
    'Varanasi': [
      'assets/photography/varanasi/1.jpg',
      'assets/photography/varanasi/2.jpg',
      'assets/photography/varanasi/3.jpg',
      'assets/photography/varanasi/4.jpg',
      'assets/photography/varanasi/5.jpg',
      'assets/photography/varanasi/6.jpg',
      'assets/photography/varanasi/7.jpg',
      'assets/photography/varanasi/8.jpg',

    ],
    'Uttarakhand': [
      'assets/photography/uttarakhand/2.jpg',
      'assets/photography/uttarakhand/1.jpg',
      'assets/photography/uttarakhand/3.jpg',
      'assets/photography/uttarakhand/4.jpg',
      'assets/photography/uttarakhand/5.jpg',
      'assets/photography/uttarakhand/6.jpg',

    ],
    'Portraits': [
      'assets/photography/potraits/1.jpg',
      'assets/photography/potraits/2.jpg',
      'assets/photography/potraits/3.jpg',
      'assets/photography/potraits/4.jpg',
      'assets/photography/potraits/5.jpg',
      'assets/photography/potraits/6.jpg',
      'assets/photography/potraits/7.jpg',
      'assets/photography/potraits/8.jpg'

    ],
  };

  @override
  Widget build(BuildContext context) {
    final titles = photoSections.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Photography')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: titles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1, // Square
          ),
          itemBuilder: (context, index) {
            final title = titles[index];
            final images = photoSections[title]!;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GalleryScreen(title: title, images: images),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      images[0],
                      fit: BoxFit.cover,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Text(
                        '$title\nClicked by Aryant Kumar',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
