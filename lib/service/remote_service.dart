import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/dayplan.dart';
import 'package:flutter_application_1/models/goals.dart';
import 'package:flutter_application_1/models/posts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'constants.dart'; // Import the constants file
const String baseUrl = 'http://10.0.2.2:8000/api/';

class RemoteService {
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> _saveToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token!);
  }

  Future<String?> _refreshToken() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String? newToken = await user.getIdToken(true);
        print('inside refresh token,$newToken'); // Force refresh token
        await _saveToken(newToken);
        return newToken;
      }
    } catch (e) {
      print('Error refreshing token: $e');
    }
    return null;
  }

  Future<http.Response> _retryRequest(http.Request originalRequest) async {
    String? newToken = await _refreshToken();
    if (newToken != null) {
      // Create a new request with the updated token
      var retryRequest = http.Request(
        originalRequest.method,
        originalRequest.url,
      )
        ..headers.addAll(originalRequest.headers)
        ..headers['Authorization'] = 'Bearer $newToken'
        ..body = originalRequest.body
        ..encoding = originalRequest.encoding;

      var client = http.Client();

      try {
        var res =
            await client.send(retryRequest).then(http.Response.fromStream);
        print('Retrying request with new token: ${res.statusCode} ${res.body}');
        return res;
      } catch (e) {
        print('Error sending request: $e');
        rethrow;
      } finally {
        client.close(); // Ensure the client is closed properly
      }
    }
    throw Exception('Failed to refresh token');
  }

  Future<http.Response> _makeRequestWithRetry(http.Request request) async {
    http.Response response =
        await http.Client().send(request).then(http.Response.fromStream);
    if (response.statusCode == 401) {
      // Token might be expired, try refreshing it
      response = await _retryRequest(request);
      print('Token expired, retrying request $response');
    }
    return response;
  }

  Future<void> sendTokenToBackend(String idToken) async {
    final response = await http.post(
      Uri.parse('${baseUrl}login'), // Use the baseUrl constant
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'idToken': idToken,
      }),
    );

    if (response.statusCode == 200) {
      print('User added to Firestore');
    } else {
      print('Failed to add user to Firestore');
    }
  }

  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var token = await _getToken();

    var response = await client.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print('${response.body} "response"');
      var json = [
        {
          "postId": 1,
          "id": 1,
          "name": "id labore ex et quam laborum",
          "email": "Eliseo@gardner.biz",
          "body":
              "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
        },
        {
          "postId": 1,
          "id": 2,
          "name": "quo vero reiciendis velit similique earum",
          "email": "Jayne_Kuhic@sydney.com",
          "body":
              "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et"
        },
      ];
      return json.map((post) => Post.fromJson(post)).toList();
    } else {
      throw ('error');
    }
  }

  Future<List<dynamic>> getGoals() async {
    var client = http.Client();
    var uri =
        Uri.parse("${baseUrl}goal-recommendation"); // Use the baseUrl constant
    var token = await _getToken();
    var request = http.Request('GET', uri);
    request.headers['Authorization'] = 'Bearer $token';
    try {
      http.Response response = await _makeRequestWithRetry(request);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('$jsonData jsonData'); // For debugging
        return jsonData["data"];
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error vdeve');
      return [];
    } finally {
      client.close();
    }
  }

  Future<DayPlan> fetchDayPlan(String url) async {
    var token = await _getToken();
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var json = response.body;
      var jsonData = jsonDecode(json);
      return DayPlan.fromJson(jsonData);
    } else {
      throw Exception('Failed to load day plan');
    }
  }

  Future<List<dynamic>?> getQuestionnaire() async {
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var token = await _getToken();

    var response = await client.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Stream<List<dynamic>> fetchDataStream() async* {
    var token = await _getToken();
    final response = await http.get(
      Uri.parse('${baseUrl}questionnaire'), // Use the baseUrl constant
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      yield data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Stream<List<dynamic>> getDayList(String goalId) async* {
  //   var token = await _getToken();
  //   final response = await http.get(
  //     Uri.parse(
  //         '${baseUrl}stream-goal-targets?goal_id=$goalId'), // Use the baseUrl constant
  //     headers: {'Authorization': 'Bearer $token'},
  //   );

  //   if (response.statusCode == 200) {
  //     List<dynamic> data = json.decode(response.body);
  //     yield data;
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  Stream<Map<String, dynamic>> getDayList(goalId) async* {
    http.Client client = http.Client();
    http.Request request = http.Request(
      'GET',
      Uri.parse('${baseUrl}stream-goal-targets?goal_id=$goalId'),
    );

    try {
      final response = await client.send(request);
      await for (var event in response.stream.transform(utf8.decoder)) {
        Map<String, dynamic> jsonData = jsonDecode(event);
        yield jsonData;
      }
    } catch (error) {
      print('Error: $error');
      yield {};
    } finally {
      client.close();
    }
  }

  Future<String> chatWithAI(String userMessage) async {
    final url = Uri.parse('${baseUrl}chat'); // Use the baseUrl constant
    var token = await _getToken();
    print("token $token");
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'user_message': userMessage,
          "user_id": "XZUGbVJiMQOM6IW6KCebjCHKLBA2"
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Data received: ${data["data"]}');
        return data["data"] ?? 'No response';
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      return 'Error: ${e.toString()}';
    }
  }

  Future<String> postQuestionnaire(userMessage) async {
    final url =
        Uri.parse('${baseUrl}questionnaire'); // Use the baseUrl constant
    var token = await _getToken();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'questionnaireResponse': userMessage}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Data received: $data');
        return data['gemini_call_resp'] ?? 'No response';
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      return 'Error: ${e.toString()}';
    }
  }

  Future<String> postMood(userMessage) async {
    final url = Uri.parse('${baseUrl}moods'); // Use the baseUrl constant
    var token = await _getToken();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(userMessage),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Data received: $data');
        return data['gemini_call_resp'] ?? 'No response';
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      return 'Error: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> fetchDashboardData(String userId) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/get-dashboard-data/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }
}
