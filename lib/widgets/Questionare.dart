// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/service/remote_service.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'package:shimmer/shimmer.dart';

// class QuestionnaireModal extends StatefulWidget {
//   @override
//   _QuestionnaireModalState createState() => _QuestionnaireModalState();
// }

// class _QuestionnaireModalState extends State<QuestionnaireModal> {
//   int _currentSectionIndex = 0;
//   Map<int, Map<int, String>> _selectedOptions = {};
//   Map<int, Map<int, String>> _textInputs = {};
//   final StreamController<Map<String, dynamic>> _streamController =
//       StreamController();
//   Map<String, dynamic> _sections = {};
//   bool _isLoading = false; // New state variable for loading

//   @override
//   void initState() {
//     super.initState();
//     _startSSEConnection();
//   }

//   void _startSSEConnection() {
//     establishSSEConnection().listen((data) {
//       setState(() {
//         _sections = data['questionnaire'] as Map<String, dynamic>;
//         _streamController.add(data);
//       });
//     }, onError: (error) {
//       print('Error receiving data: $error');
//     });
//   }

//   Stream<Map<String, dynamic>> establishSSEConnection() async* {
//     http.Client client = http.Client();
//     http.Request request = http.Request(
//         'GET', Uri.parse('http://10.0.2.2:8000/api/questionnaire'));

//     try {
//       final response = await client.send(request);
//       await for (var event in response.stream.transform(utf8.decoder)) {
//         Map<String, dynamic> jsonData = jsonDecode(event);
//         yield jsonData;
//       }
//     } catch (error) {
//       print('Error: $error');
//       yield {};
//     } finally {
//       client.close();
//     }
//   }

//   void _nextSection() async {
//     if (_currentSectionIndex < _getSectionKeys().length - 1) {
//       setState(() {
//         _currentSectionIndex++;
//       });
//     } else {
//       setState(() {
//         _isLoading = true; // Set loading state
//       });

//       final response = _generateResponse();
//       try {
//         await RemoteService().postQuestionnaire(response);
//         // Optionally, handle success (e.g., show a success message)
//       } catch (error) {
//         print('Error posting data: $error');
//       } finally {
//         setState(() {
//           _isLoading = false; // Reset loading state
//         });
//         Navigator.pop(context); // Close the modal
//       }
//     }
//   }

//   List<String> _getSectionKeys() {
//     return _sections.keys.toList();
//   }

//   Map<String, dynamic> _generateResponse() {
//     Map<String, dynamic> response = {};

//     _sections.forEach((sectionKey, section) {
//       List<Map<String, String>> answers = [];
//       section.forEach((item) {
//         int itemIndex = section.indexOf(item);
//         if (item['question'] != null) {
//           String? answer;
//           if (item.containsKey('options')) {
//             answer = _selectedOptions[_currentSectionIndex]?[itemIndex];
//           } else if (item.containsKey('type') && item['type'] == 'text') {
//             answer = _textInputs[_currentSectionIndex]?[itemIndex];
//           }
//           if (answer != null) {
//             answers.add({
//               'question': item['question'],
//               'answer': answer,
//             });
//           }
//         }
//       });
//       response[sectionKey] = answers;
//     });

//     return response;
//   }

//   @override
//   void dispose() {
//     _streamController.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: _isLoading
//               ? Center(
//                   child: Shimmer.fromColors(
//                     baseColor: Colors.grey[300]!,
//                     highlightColor: Colors.grey[100]!,
//                     child: Container(
//                       width: double.infinity,
//                       height: 60.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//               : StreamBuilder<Map<String, dynamic>>(
//                   stream: _streamController.stream,
//                   builder: (context, snapshot) {
//                     final hasData = snapshot.hasData;

//                     final sectionKeys = _getSectionKeys();
//                     final currentSectionKey = sectionKeys.isNotEmpty
//                         ? sectionKeys[_currentSectionIndex]
//                         : null;
//                     final currentSection = hasData
//                         ? (snapshot.data?['questionnaire']
//                             as Map<String, dynamic>)[currentSectionKey]
//                         : null;

//                     if (!hasData || currentSection == null) {
//                       // Show shimmer for the entire screen until data starts loading
//                       return ListView.builder(
//                         itemCount: 5, // Number of shimmer placeholders
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Shimmer.fromColors(
//                               baseColor: Colors.grey[300]!,
//                               highlightColor: Colors.grey[100]!,
//                               child: Container(
//                                 height: 60.0,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }

//                     return SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             currentSectionKey ?? '',
//                             style: TextStyle(
//                                 fontSize: 24, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 16.0),
//                           ...currentSection.map<Widget>((item) {
//                             if (item is Map<String, dynamic>) {
//                               return AnimatedSwitcher(
//                                 duration: Duration(milliseconds: 500),
//                                 child: item['question'] != null
//                                     ? Column(
//                                         key: ValueKey(item['question']),
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             item['question'] ?? '',
//                                             style: TextStyle(fontSize: 18),
//                                           ),
//                                           SizedBox(height: 16.0),
//                                           if (item.containsKey('options'))
//                                             ...(item['options']
//                                                     as List<dynamic>)
//                                                 .map<Widget>((option) {
//                                               return RadioListTile<String>(
//                                                 title: Text(option),
//                                                 value: option,
//                                                 groupValue: _selectedOptions[
//                                                         _currentSectionIndex]?[
//                                                     currentSection
//                                                         .indexOf(item)],
//                                                 onChanged: (value) {
//                                                   setState(() {
//                                                     _selectedOptions[
//                                                         _currentSectionIndex] ??= {};
//                                                     _selectedOptions[
//                                                             _currentSectionIndex]![
//                                                         currentSection.indexOf(
//                                                             item)] = value!;
//                                                   });
//                                                 },
//                                               );
//                                             }).toList(),
//                                           if (item.containsKey('type') &&
//                                               item['type'] == 'text')
//                                             TextField(
//                                               onChanged: (value) {
//                                                 setState(() {
//                                                   _textInputs[
//                                                       _currentSectionIndex] ??= {};
//                                                   _textInputs[
//                                                           _currentSectionIndex]![
//                                                       currentSection.indexOf(
//                                                           item)] = value;
//                                                 });
//                                               },
//                                               decoration: InputDecoration(
//                                                 border: OutlineInputBorder(),
//                                                 labelText: 'Your answer',
//                                               ),
//                                             ),
//                                           SizedBox(height: 16.0),
//                                         ],
//                                       )
//                                     : Shimmer.fromColors(
//                                         key: ValueKey(
//                                             'shimmer_${currentSection.indexOf(item)}'),
//                                         baseColor: Colors.grey[300]!,
//                                         highlightColor: Colors.grey[100]!,
//                                         child: Container(
//                                           height: 60.0,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                               );
//                             } else {
//                               return Container();
//                             }
//                           }).toList(),
//                           ElevatedButton(
//                             onPressed: _nextSection,
//                             child: Text(
//                                 _currentSectionIndex < sectionKeys.length - 1
//                                     ? 'Next Section'
//                                     : 'Finish'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/remote_service.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class QuestionnaireModal extends StatefulWidget {
  @override
  _QuestionnaireModalState createState() => _QuestionnaireModalState();
}

class _QuestionnaireModalState extends State<QuestionnaireModal> {
  Map<String, Map<int, String>> _selectedOptions = {};
  Map<String, Map<int, String>> _textInputs = {};
  final StreamController<Map<String, dynamic>> _streamController =
      StreamController();
  Map<String, dynamic> _questions = {};
  bool _isLoading = false;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _startSSEConnection();
  }

  void _startSSEConnection() {
    establishSSEConnection().listen(
      (data) {
        try {
          final Map<String, dynamic> parsedData = jsonDecode(data);
          setState(() {
            _questions = parsedData['questionnaire'] as Map<String, dynamic>;
            _isDataLoaded = true; // Mark data as loaded
            _streamController.add(parsedData);
          });
        } catch (error) {
          print('Error parsing JSON data: $error');
          // Handle JSON parsing errors
        }
      },
      onError: (error) {
        print('Error receiving data: $error');
      },
      onDone: () {
        print('Stream closed.');
        _streamController.close(); // Ensure the stream controller is closed
      },
    );
  }

  Stream<String> establishSSEConnection() async* {
    http.Client client = http.Client();
    http.Request request = http.Request(
        'GET', Uri.parse('http://10.0.2.2:8000/api/questionnaire'));

    try {
      final response = await client.send(request);
      await for (var event in response.stream.transform(utf8.decoder)) {
        yield event; // Yield raw string data
      }
    } catch (error) {
      print('Error: $error');
      yield ''; // Yield empty string on error
    } finally {
      client.close();
    }
  }

  void _submitResponses() async {
    setState(() {
      _isLoading = true; // Set loading state
    });

    final response = _generateResponse();
    try {
      await RemoteService().postQuestionnaire(response);
      // Optionally, handle success (e.g., show a success message)
    } catch (error) {
      print('Error posting data: $error');
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
      });
      Navigator.pop(context); // Close the modal
    }
  }

  Map<String, dynamic> _generateResponse() {
    Map<String, dynamic> response = {};

    _questions.forEach((questionKey, question) {
      List<Map<String, String>> answers = [];
      question.forEach((item) {
        int itemIndex = question.indexOf(item);
        if (item['question'] != null) {
          String? answer;
          if (item.containsKey('options')) {
            answer = _selectedOptions[questionKey]?[itemIndex];
          } else if (item.containsKey('type') && item['type'] == 'text') {
            answer = _textInputs[questionKey]?[itemIndex];
          }
          if (answer != null) {
            answers.add({
              'question': item['question'],
              'answer': answer,
            });
          }
        }
      });
      response[questionKey] = answers;
    });

    return response;
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<Map<String, dynamic>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              final hasData = snapshot.hasData;

              Map<String, dynamic>? questions = snapshot.data?['questionnaire'];

              if (!hasData || questions == null) {
                // Show shimmer for the entire screen until data starts loading
                return ListView.builder(
                  itemCount: 5, // Number of shimmer placeholders
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 60.0,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...questions.keys.map((key) {
                      final questionList = questions[key] as List<dynamic>;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            key,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16.0),
                          ...questionList.map<Widget>((item) {
                            if (item is Map<String, dynamic>) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['question'] ?? '',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: 16.0),
                                  if (item.containsKey('options') &&
                                      item['options'] is List<dynamic>)
                                    ...(item['options'] as List<dynamic>)
                                        .map<Widget>((option) {
                                      return RadioListTile<String>(
                                        title: Text(option),
                                        value: option,
                                        groupValue: _selectedOptions[key]
                                            ?[questionList.indexOf(item)],
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedOptions[key] ??= {};
                                            _selectedOptions[key]![questionList
                                                .indexOf(item)] = value!;
                                          });
                                        },
                                      );
                                    }).toList(),
                                  if (item.containsKey('type') &&
                                      item['type'] == 'text')
                                    TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          _textInputs[key] ??= {};
                                          _textInputs[key]![questionList
                                              .indexOf(item)] = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Your answer',
                                      ),
                                    ),
                                  SizedBox(height: 16.0),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }).toList(),
                          SizedBox(height: 24.0),
                        ],
                      );
                    }).toList(),
                    if (snapshot.connectionState != ConnectionState.done)
                      Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 20.0,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8.0),
                              Container(
                                width: double.infinity,
                                height: 16.0,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8.0),
                              Container(
                                width: double.infinity,
                                height: 16.0,
                                color: Colors.white,
                              ),
                            ],
                          )),
                    if (snapshot.connectionState == ConnectionState.done)
                      ElevatedButton(
                        onPressed: _isLoading ? null : _submitResponses,
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text('Finish'),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
