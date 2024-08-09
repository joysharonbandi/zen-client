import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/remote_service.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  final types.User _user = types.User(
      id: 'XZUGbVJiMQOM6IW6KCebjCHKLBA2'); // Replace with actual user ID
  final types.User _bot = types.User(id: 'bot-id', firstName: 'ZEN');

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  Future<void> _loadInitialMessages() async {
    try {
      final data = await RemoteService().getChatData(
        _user.id,
      ) as List<dynamic>;

      setState(() {
        _messages = data.map((message) {
          final isBot = message['chat_from'] == 'AI';
          final author = isBot ? _bot : _user;

          return types.TextMessage(
            author: author,
            createdAt:
                message['created_at'] ?? DateTime.now().millisecondsSinceEpoch,
            id: Random().nextInt(100000).toString(),
            text: message['message'] ?? 'No message text available',
          );
        }).toList();
      });

      // if (response.statusCode == 200) {
      //   final List<dynamic> data = jsonDecode(response.body)["data"];

      //   setState(() {
      //     _messages = data.map((message) {
      //       final isBot = message['chat_from'] == 'AI';
      //       final author = isBot ? _bot : _user;

      //       return types.TextMessage(
      //         author: author,
      //         createdAt: message['created_at'] ??
      //             DateTime.now().millisecondsSinceEpoch,
      //         id: Random().nextInt(100000).toString(),
      //         text: message['message'] ?? 'No message text available',
      //       );
      //     }).toList();
      //   });
      // } else {
      //   print('Failed to load messages: ${response.statusCode}');
      // }
    } catch (error) {
      print('Error loading messages: $error');
    }
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: Random().nextInt(100000).toString(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });

    _sendBotResponse(message.text);
  }

  void _sendBotResponse(String userMessage) async {
    try {
      final response = await RemoteService().chatWithAI(userMessage);
      print('Data received: $response');

      final botResponse = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: Random().nextInt(100000).toString(),
        text: response,
      );

      setState(() {
        _messages.insert(0, botResponse);
      });
    } catch (error) {
      print('Error: $error');
      final botResponse = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: Random().nextInt(100000).toString(),
        text: 'Error: ${error.toString()}',
      );

      setState(() {
        _messages.insert(0, botResponse);
      });
    }
  }

  final ThemeData _customTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color.fromARGB(255, 190, 151, 229),
      primary: Color.fromARGB(255, 120, 81, 169),
      secondary: Color.fromARGB(255, 233, 220, 252),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 120, 81, 169),
      foregroundColor: Colors.white,
    ),
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: Color.fromARGB(255, 233, 220, 252),
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(20.0),
    //     borderSide: BorderSide.none,
    //   ),
    // ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 240, 255),
        appBar: AppBar(
          title: Text(
            'ZEN BOT',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          elevation: 0,
        ),
        body: Theme(
          data: _customTheme,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
              showUserAvatars: true,
              showUserNames: true,
              bubbleBuilder: _bubbleBuilder,
              theme: DefaultChatTheme(
                inputBackgroundColor:
                    Color.fromARGB(255, 89, 67, 122).withOpacity(0.9),
              ),
            ),
          ),
        ));
  }

  Widget _bubbleBuilder(Widget child,
      {required types.Message message, required bool nextMessageInGroup}) {
    final isBot = message.author.id == 'bot-id';
    return Container(
      decoration: BoxDecoration(
        color: isBot
            ? Color.fromARGB(255, 120, 81, 169).withOpacity(0.9)
            : Color.fromARGB(255, 89, 67, 122).withOpacity(0.9),
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: child,
      ),
    );
  }
}
