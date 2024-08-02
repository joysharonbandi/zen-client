// import 'package:flutter_application_1/models/goals.dart';
// import 'package:http/http.dart' as http;

// class RemoteService {
//   Future<Welcome?> getGoals() async {
//     var client = http.Client();

//     var uri = Uri.parse('https://jsonplaceholder.typicode.com/comments');
//     var response = await client.get(uri);
//     if (response.statusCode == 200) {
//       var json = response.body;
//       return welcomeFromJson(json);
//     } else {
//       throw ('error');
//     }
//   }
// }

import 'dart:convert';
import 'dart:async';
import 'package:flutter_application_1/models/dayplan.dart';
import 'package:flutter_application_1/models/goals.dart';
import 'package:flutter_application_1/models/posts.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();

    var uri = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await client.get(uri);
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

  Future<List<Goal>?> getGoals() async {
    var client = http.Client();

    var uri = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      print('${response.body} "response"');
      var json = [
        {
          "title": "SLEEP",
          "id": 1,
          "status": "id labore ex et quam laborum",
          "benefits": "Eliseo@gardner.biz",
          "longDescription":
              "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
        },
        {
          "title": "ANGER",
          "id": 1,
          "status": "id labore ex et quam laborum",
          "benefits": "Eliseo@gardner.biz",
          "longDescription":
              "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
        },
      ];
      return json.map((post) => Goal.fromJson(post)).toList();
    } else {
      throw ('error');
    }
  }

  Future<DayPlan> fetchDayPlan(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = response.body;
      // If the server returns a 200 OK response, parse the JSON
      var jsonData = jsonDecode(json);
      return DayPlan.fromJson(jsonData);
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load day plan');
    }
  }

  Future<List<dynamic>?> getQuestionnaire() async {
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Stream<List<dynamic>> fetchDataStream() async* {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/questionnaire'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      yield data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

Stream<List<dynamic>> establishSSEConnection() async* {
  http.Client client = http.Client();
  http.Request request =
      http.Request('GET', Uri.parse('http://10.0.2.2:8000/api/questionnaire'));

  try {
    final response = await client.send(request);
    await for (var event in response.stream.transform(utf8.decoder)) {
      // Decode the JSON response
      Map<String, dynamic> jsonData = jsonDecode(event);
      yield [jsonData];
    }
  } catch (error) {
    // Handle any error that occurs while establishing the connection or during data retrieval
    print('Error: $error');
    yield [];
  } finally {
    client.close();
  }
}
