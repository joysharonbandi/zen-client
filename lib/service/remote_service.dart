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
}
