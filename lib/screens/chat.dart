// import 'dart:convert';
// import 'dart:io';

// // import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:image_picker/image_picker.dart';
// // import 'package:intl/date_symbol_data_local.dart';
// // import 'package:mime/mime.dart';
// // import 'package:open_filex/open_filex.dart';
// // import 'package:path_provider/path_provider.dart';
// import 'package:uuid/uuid.dart';

// // void main() {
// //   initializeDateFormatting().then((_) => runApp(const MyApp()));
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) => const MaterialApp(
// //         home: Directionality(
// //           textDirection: TextDirection.ltr,
// //           child: ChatPage(),
// //         ),
// //       );
// // }

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   List<types.Message> _messages = [];
//   final _user = const types.User(
//     id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
//   );

//   @override
//   void initState() {
//     super.initState();
//     _loadMessages();
//   }

//   void _addMessage(types.Message message) {
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }

//   void _handleAttachmentPressed() {
//     showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) => SafeArea(
//         child: SizedBox(
//           height: 144,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   // _handleImageSelection();
//                 },
//                 child: const Align(
//                   alignment: AlignmentDirectional.centerStart,
//                   child: Text('Photo'),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   // _handleFileSelection();
//                 },
//                 child: const Align(
//                   alignment: AlignmentDirectional.centerStart,
//                   child: Text('File'),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Align(
//                   alignment: AlignmentDirectional.centerStart,
//                   child: Text('Cancel'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // void _handleFileSelection() async {
//   //   final result = await FilePicker.platform.pickFiles(
//   //     type: FileType.any,
//   //   );

//   //   if (result != null && result.files.single.path != null) {
//   //     final message = types.FileMessage(
//   //       author: _user,
//   //       createdAt: DateTime.now().millisecondsSinceEpoch,
//   //       id: const Uuid().v4(),
//   //       mimeType: lookupMimeType(result.files.single.path!),
//   //       name: result.files.single.name,
//   //       size: result.files.single.size,
//   //       uri: result.files.single.path!,
//   //     );

//   //     _addMessage(message);
//   //   }
//   // }

//   // void _handleImageSelection() async {
//   //   final result = await ImagePicker().pickImage(
//   //     imageQuality: 70,
//   //     maxWidth: 1440,
//   //     source: ImageSource.gallery,
//   //   );

//   //   if (result != null) {
//   //     final bytes = await result.readAsBytes();
//   //     final image = await decodeImageFromList(bytes);

//   //     final message = types.ImageMessage(
//   //       author: _user,
//   //       createdAt: DateTime.now().millisecondsSinceEpoch,
//   //       height: image.height.toDouble(),
//   //       id: const Uuid().v4(),
//   //       name: result.name,
//   //       size: bytes.length,
//   //       uri: result.path,
//   //       width: image.width.toDouble(),
//   //     );

//   //     _addMessage(message);
//   //   }
//   // }

//   // void _handleMessageTap(BuildContext _, types.Message message) async {
//   //   if (message is types.FileMessage) {
//   //     var localPath = message.uri;

//   //     if (message.uri.startsWith('http')) {
//   //       try {
//   //         final index =
//   //             _messages.indexWhere((element) => element.id == message.id);
//   //         final updatedMessage =
//   //             (_messages[index] as types.FileMessage).copyWith(
//   //           isLoading: true,
//   //         );

//   //         setState(() {
//   //           _messages[index] = updatedMessage;
//   //         });

//   //         final client = http.Client();
//   //         final request = await client.get(Uri.parse(message.uri));
//   //         final bytes = request.bodyBytes;
//   //         final documentsDir = (await getApplicationDocumentsDirectory()).path;
//   //         localPath = '$documentsDir/${message.name}';

//   //         if (!File(localPath).existsSync()) {
//   //           final file = File(localPath);
//   //           await file.writeAsBytes(bytes);
//   //         }
//   //       } finally {
//   //         final index =
//   //             _messages.indexWhere((element) => element.id == message.id);
//   //         final updatedMessage =
//   //             (_messages[index] as types.FileMessage).copyWith(
//   //           isLoading: null,
//   //         );

//   //         setState(() {
//   //           _messages[index] = updatedMessage;
//   //         });
//   //       }
//   //     }

//   //     await OpenFilex.open(localPath);
//   //   }
//   // }

//   void _handlePreviewDataFetched(
//     types.TextMessage message,
//     types.PreviewData previewData,
//   ) {
//     final index = _messages.indexWhere((element) => element.id == message.id);
//     final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
//       previewData: previewData,
//     );

//     setState(() {
//       _messages[index] = updatedMessage;
//     });
//   }

//   void _handleSendPressed(types.PartialText message) {
//     final textMessage = types.TextMessage(
//       author: _user,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: message.text,
//     );

//     _addMessage(textMessage);
//   }

//   void _loadMessages() async {
//     final response = await rootBundle.loadString('assets/messages.json');
//     final messages = (jsonDecode(response) as List)
//         .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
//         .toList();

//     setState(() {
//       _messages = messages;
//     });
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: Chat(
//           messages: _messages,
//           onAttachmentPressed: _handleAttachmentPressed,
//           // onMessageTap: _handleMessageTap,
//           onPreviewDataFetched: _handlePreviewDataFetched,
//           onSendPressed: _handleSendPressed,
//           showUserAvatars: true,
//           showUserNames: true,
//           user: _user,
//         ),
//       );
// }

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  final types.User _user = types.User(id: 'user-id');
  final types.User _bot = types.User(id: 'bot-id', firstName: 'ChatBot');

  @override
  void initState() {
    super.initState();
    // Load initial messages if necessary
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

  // void _sendBotResponse(String userMessage) {
  //   // Call chatWithAI function and listen to the stream
  //   chatWithAI(userMessage).listen((data) {
  //     print('Data received: $data');
  //     if (data.isNotEmpty) {
  //       final botResponse = types.TextMessage(
  //         author: _bot,
  //         createdAt: DateTime.now().millisecondsSinceEpoch,
  //         id: Random().nextInt(100000).toString(),
  //         text: data[0]['message'] ?? 'No response',
  //       );

  //       setState(() {
  //         _messages.insert(0, botResponse);
  //       });
  //     } else {
  //       // Handle the case where no data is received
  //       final botResponse = types.TextMessage(
  //         author: _bot,
  //         createdAt: DateTime.now().millisecondsSinceEpoch,
  //         id: Random().nextInt(100000).toString(),
  //         text: 'No response',
  //       );

  //       setState(() {
  //         _messages.insert(0, botResponse);
  //       });
  //     }
  //   }).onError((error) {
  //     // Handle errors from the stream
  //     print('Stream error: $error');
  //     final botResponse = types.TextMessage(
  //       author: _bot,
  //       createdAt: DateTime.now().millisecondsSinceEpoch,
  //       id: Random().nextInt(100000).toString(),
  //       text: 'Error: ${error.toString()}',
  //     );

  //     setState(() {
  //       _messages.insert(0, botResponse);
  //     });
  //   });
  // }

  void _sendBotResponse(String userMessage) async {
    try {
      // Call chatWithAI function and wait for the response
      final response = await chatWithAI(userMessage);
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
      // Handle errors from the function
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
      primary: Color.fromARGB(255, 190, 151, 229),
      secondary: Color.fromARGB(255, 201, 184, 219),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 190, 151, 229),
      foregroundColor: Colors.white,
    ),
    // textTheme: TextTheme(
    //   headline1: TextStyle(color: Colors.black87, fontSize: 24.0), // Large text
    //   headline2:
    //       TextStyle(color: Colors.black54, fontSize: 20.0), // Medium text
    //   bodyText1:
    //       TextStyle(color: Colors.black87, fontSize: 16.0), // Main body text
    //   bodyText2: TextStyle(
    //       color: Colors.black54, fontSize: 14.0), // Secondary body text
    //   caption: TextStyle(color: Colors.grey, fontSize: 12.0), // For captions
    // ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color.fromARGB(255, 201, 184, 219),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ChatBot'),
      ),
      body: Theme(
        data: _customTheme,
        child: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          showUserAvatars: true,
          showUserNames: true,
        ),
      ),
    );
  }
}

// Function to interact with AI and stream responses
// Stream<List<dynamic>> chatWithAI(String userMessage) async* {
//   final url = Uri.parse('http://10.0.2.2:8000/api/gemini'); // Your API endpoint

//   try {
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(
//           {'message': userMessage}), // Ensure the body is JSON-encoded
//     );

//     if (response.statusCode == 200) {
//       // Decode JSON response
//       List<dynamic> data = jsonDecode(response.body);
//       yield data; // Yield the data received from the API
//     } else {
//       // Handle non-200 responses
//       yield []; // Yield empty list or handle as required
//     }
//   } catch (e) {
//     // Handle errors
//     print('Error: $e');
//     yield []; // Yield empty list or handle as required
//   }
// }

Future<String> chatWithAI(String userMessage) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/gemini'); // Your API endpoint

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'message': userMessage}), // Ensure the body is JSON-encoded
    );

    if (response.statusCode == 200) {
      // Decode JSON response
      final data = jsonDecode(response.body);
      print('Data received: $data');
      return data['gemini_call_resp'] ??
          'No response'; // Return the specific response
    } else {
      // Handle non-200 responses
      return 'Error: ${response.statusCode}'; // Return error message
    }
  } catch (e) {
    // Handle errors
    print('Error: $e');
    return 'Error: ${e.toString()}'; // Return error message
  }
}
