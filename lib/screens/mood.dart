// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_application_1/service/remote_service.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_application_1/providers/mood_provider.dart';

// class MoodPage extends StatefulWidget {
//   final String currentMood;

//   const MoodPage({super.key, required this.currentMood});

//   @override
//   State<MoodPage> createState() => _MoodPageState();
// }

// class _MoodPageState extends State<MoodPage> {
//   late List<dynamic> videoReccomendations = [];
//   bool _isLoading = true;

//   final List<Map<String, String>> imagePaths = [
//     {"path": 'assets/images/angry_icon.png', "mood": "ANGRY"},
//     {"path": 'assets/images/sad_icon.png', "mood": "SAD"},
//     {"path": 'assets/images/smile_with_pain_icon.png', "mood": "NEUTRAL"},
//     {"path": 'assets/images/smile_icon.png', "mood": "HAPPY"},
//     {"path": 'assets/images/star.png', "mood": "EXCITED"},
//     // Add more image paths and moods as needed
//   ];

//   @override
//   void initState() {
//     super.initState();
//     fetchvideoReccomendations();
//   }

//   Future<void> fetchvideoReccomendations() async {
//     try {
//       final mood = Provider.of<MoodProvider>(context, listen: false).currentMood
//           as String;
//       final data = await RemoteService().fetchvideoReccomendations(mood);
//       if (mounted) {
//         setState(() {
//           videoReccomendations = data;
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('Error fetching video recommendations: $e');
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color secondaryColor = Color.fromARGB(255, 255, 247, 255);

//     return Scaffold(
//       backgroundColor: secondaryColor,
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView(
//               padding: EdgeInsets.symmetric(horizontal: 12),
//               children: [
//                 _buildMoodHeader(),
//                 SizedBox(height: 16),
//                 ..._buildSectionsFromData(videoReccomendations),
//               ],
//             ),
//     );
//   }

//   Widget _buildMoodHeader() {
//     final mood =
//         Provider.of<MoodProvider>(context, listen: false).currentMood as String;
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white, // Customize the color to match your theme
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // _getMoodIcon(widget.currentMood),
//           Expanded(
//             child: Text(
//               mood,
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.primary,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 0.5,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           // _getMoodIcon(widget.currentMood),
//         ],
//       ),
//     );
//   }

//   Widget _getMoodIcon(String mood) {
//     final moodData = imagePaths.firstWhere(
//       (entry) => entry['mood'] == mood,
//       orElse: () => {"path": 'assets/images/smile_icon.png'}, // Default icon
//     );
//     return Image.asset(
//       moodData['path']!,
//       width: 32,
//       height: 32,
//     );
//   }

//   List<Widget> _buildSectionsFromData(List<dynamic> data) {
//     List<Widget> sections = [];

//     for (var section in data) {
//       String sectionTitle = section["sectionTitle"];
//       List<Map<String, String>> images = [];

//       for (var result in section["searchResults"]) {
//         for (var item in result["items"]) {
//           images.add({
//             'image': item['snippet']['thumbnails']['high']['url'],
//             'title': item['snippet']['title'],
//             'description': item['snippet']['description'],
//             'url': 'https://www.youtube.com/watch?v=${item['id']['videoId']}',
//           });
//         }
//       }

//       sections.add(
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.white, // Change this to your desired background color
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Section Header
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 child: Text(
//                   sectionTitle,
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.primary,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 12),
//               // Carousel
//               CarouselSlider(
//                 options: CarouselOptions(
//                   height: 250,
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   viewportFraction: 0.8,
//                   aspectRatio: 16 / 9,
//                   autoPlayInterval: Duration(seconds: 5),
//                   autoPlayAnimationDuration: Duration(milliseconds: 800),
//                   scrollDirection: Axis.horizontal,
//                 ),
//                 items: images.map((item) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.network(
//                               item['image']!,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 12,
//                             left: 12,
//                             right: 12,
//                             child: Container(
//                               padding: EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.6),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item['title']!,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                   ),
//                                   SizedBox(height: 6),
//                                   Text(
//                                     item['description']!,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                   ),
//                                   SizedBox(height: 8),
//                                   ElevatedButton(
//                                     onPressed: () async {
//                                       final url = item['url'];
//                                       await launchUrl(Uri.parse(url ?? ''));
//                                     },
//                                     child: Text('Watch Now'),
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.white,
//                                       foregroundColor:
//                                           Theme.of(context).colorScheme.primary,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 12),
//             ],
//           ),
//         ),
//       );
//     }

//     return sections;
//   }
// }

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_1/service/remote_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/mood_provider.dart';

class MoodPage extends StatefulWidget {
  final String currentMood;

  const MoodPage({super.key, required this.currentMood});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  late List<dynamic> videoRecommendations = [];
  bool _isLoading = true;

  final List<Map<String, String>> imagePaths = [
    {"path": 'assets/images/angry_icon.png', "mood": "ANGRY"},
    {"path": 'assets/images/sad_icon.png', "mood": "SAD"},
    {"path": 'assets/images/smile_with_pain_icon.png', "mood": "NEUTRAL"},
    {"path": 'assets/images/smile_icon.png', "mood": "HAPPY"},
    {"path": 'assets/images/star.png', "mood": "EXCITED"},
    // Add more image paths and moods as needed
  ];

  @override
  void initState() {
    super.initState();
    fetchvideoRecommendations();
  }

  Future<void> fetchvideoRecommendations() async {
    try {
      final mood = Provider.of<MoodProvider>(context, listen: false).currentMood
          as String?;
      if (mood != null) {
        final data = await RemoteService().fetchvideoReccomendations(mood);
        print("data  $data");
        if (mounted) {
          setState(() {
            videoRecommendations = data ?? [];
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching video recommendations: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color secondaryColor = Color.fromARGB(255, 255, 247, 255);

    return Scaffold(
      backgroundColor: secondaryColor,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildMoodHeader(),
                SizedBox(height: 16),
                ..._buildSectionsFromData(videoRecommendations),
              ],
            ),
    );
  }

  Widget _buildMoodHeader() {
    final mood = Provider.of<MoodProvider>(context, listen: false).currentMood
        as String?;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Customize the color to match your theme
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              mood ?? 'Unknown Mood',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMoodIcon(String mood) {
    final moodData = imagePaths.firstWhere(
      (entry) => entry['mood'] == mood,
      orElse: () => {"path": 'assets/images/smile_icon.png'}, // Default icon
    );
    return Image.asset(
      moodData['path']!,
      width: 32,
      height: 32,
    );
  }

  List<Widget> _buildSectionsFromData(List<dynamic> data) {
    List<Widget> sections = [];

    for (var section in data) {
      String sectionTitle = section["sectionTitle"] ?? 'Untitled Section';
      List<Map<String, String>> images = [];

      if (section["searchResults"] != null) {
        for (var result in section["searchResults"]) {
          if (result["items"] != null) {
            for (var item in result["items"]) {
              images.add({
                'image': item['snippet']['thumbnails']['high']['url'] ?? '',
                'title': item['snippet']['title'] ?? 'No Title',
                'description':
                    item['snippet']['description'] ?? 'No Description',
                'url':
                    'https://www.youtube.com/watch?v=${item['id']['videoId'] ?? ''}',
              });
            }
          }
        }
      }

      sections.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  sectionTitle,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(height: 12),
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
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                  child: Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                );
                              },
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
                                borderRadius: BorderRadius.circular(12),
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
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    item['description']!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final url = item['url'];
                                      if (url != null && url.isNotEmpty) {
                                        await launchUrl(Uri.parse(url));
                                      }
                                    },
                                    child: Text('Watch Now'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor:
                                          Theme.of(context).colorScheme.primary,
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
        ),
      );
    }

    return sections;
  }
}
