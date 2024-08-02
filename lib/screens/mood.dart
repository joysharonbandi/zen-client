import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  final List<Map<String, String>> imgList = [
    {
      'image': 'https://picsum.photos/seed/picsum/800/400',
      'title': 'Mountain',
      'description': 'Explore breathtaking mountain views.',
    },
    {
      'image': 'https://picsum.photos/id/237/800/400',
      'title': 'Dog',
      'description': 'Adorable moments with dogs.',
    },
    {
      'image': 'https://picsum.photos/800/400?grayscale',
      'title': 'Friends',
      'description': 'Cherished moments with friends.',
    },
  ];

  final List<Map<String, String>> imgList2 = [
    {
      'image': 'https://picsum.photos/seed/sunflower/800/400',
      'title': 'Sunflower',
      'description': 'Bright and cheerful sunflower.',
    },
    {
      'image': 'https://picsum.photos/seed/ocean/800/400',
      'title': 'Ocean',
      'description': 'A serene view of the ocean.',
    },
  ];

  final List<Map<String, String>> imgList3 = [
    {
      'image': 'https://picsum.photos/seed/forest/800/400',
      'title': 'Forest',
      'description': 'Lush green forest.',
    },
    {
      'image': 'https://picsum.photos/seed/city/800/400',
      'title': 'City',
      'description': 'A vibrant cityscape.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Section(
            title: 'Mountain Adventure',
            description: 'Discover breathtaking mountain views.',
            images: imgList,
          ),
          _buildCustomDivider(),
          Section(
            title: 'Nature & Sun',
            description: 'Bright and cheerful scenes of nature.',
            images: imgList2,
          ),
          _buildCustomDivider(),
          Section(
            title: 'Urban & Forest',
            description:
                'Explore the contrasts of urban and natural landscapes.',
            images: imgList3,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      height: 1,
      color: Colors.grey[300],
      width: double.infinity,
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final String description;
  final List<Map<String, String>> images;

  const Section({
    Key? key,
    required this.title,
    required this.description,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              title,
              style: TextStyle(
                color: primaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 12),
          // Carousel
          CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              aspectRatio: 16 / 9,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              scrollDirection: Axis.horizontal,
            ),
            items: images.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                item['description']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Open'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
