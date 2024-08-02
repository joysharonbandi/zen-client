import 'dart:convert';
import 'package:flutter/material.dart';

class QuestionnaireModal extends StatefulWidget {
  @override
  _QuestionnaireModalState createState() => _QuestionnaireModalState();
}

class _QuestionnaireModalState extends State<QuestionnaireModal> {
  int _currentSectionIndex = 0;
  Map<int, Map<int, String>> _selectedOptions = {};

  final String jsonData = '''
  {
    "questionnaire": {
        "Mental Wellness Assessment": [
            {
                "question": "How often do you feel anxious ?",
                "options": [
                    "Rarely",
                    "Sometimes",
                    "Often",
                    "Always"
                ]
            },
            {
                "question": "How often do you feel anxious ?",
                "options": [
                    "Rarely",
                    "Sometimes",
                    "Often",
                    "Always"
                ]
            },
             {
                "question": "How often do you feel anxious ?",
                "options": [
                    "Rarely",
                    "Sometimes",
                    "Often",
                    "Always"
                ]
            }
        ],
        "Activity Preference": [
            {
                "question": "What kind of activities do you like or willing to try ?",
                "options": [
                    "Meditation",
                    "Yoga",
                    "Journaling",
                    "Physical exercise",
                    "Reading self-help books",
                    "Listening to relaxing music",
                    "Creative activities",
                    "Socializing with friends or family",
                    "Other"
                ]
            }
        ]
    }
  }
  ''';

  List<Map<String, dynamic>> _sections = [];

  @override
  void initState() {
    super.initState();
    _parseJsonData();
  }

  void _parseJsonData() {
    final Map<String, dynamic> parsedData = jsonDecode(jsonData);
    final questionnaire = parsedData['questionnaire'] as Map<String, dynamic>;

    questionnaire.forEach((section, questions) {
      _sections.add({
        'section': section,
        'questions': questions,
      });
    });
  }

  void _nextSection() {
    if (_currentSectionIndex < _sections.length - 1) {
      setState(() {
        _currentSectionIndex++;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSection = _sections[_currentSectionIndex];
    final questions = currentSection['questions'];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Questionnaire'),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentSection['section'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                ...questions.asMap().entries.map<Widget>((entry) {
                  int questionIndex = entry.key;
                  Map<String, dynamic> question = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question['question'],
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16.0),
                      ...question['options'].map<Widget>((option) {
                        return RadioListTile<String>(
                          title: Text(option),
                          value: option,
                          groupValue: _selectedOptions[_currentSectionIndex]
                              ?[questionIndex],
                          onChanged: (value) {
                            setState(() {
                              _selectedOptions[_currentSectionIndex] ??= {};
                              _selectedOptions[_currentSectionIndex]![
                                  questionIndex] = value!;
                            });
                          },
                        );
                      }).toList(),
                      SizedBox(height: 16.0),
                    ],
                  );
                }).toList(),
                ElevatedButton(
                  onPressed: _nextSection,
                  child: Text(_currentSectionIndex < _sections.length - 1
                      ? 'Next Section'
                      : 'Finish'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
