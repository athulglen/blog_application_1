// http_service.dart

import 'dart:convert';
import 'package:blog_application_1/Api%20Blog/model/post_model.dart';
import 'package:blog_application_1/Api%20Blog/model/user_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));

      if (response.statusCode == 200) {
        // Users fetched successfully
        Iterable jsonResponse = jsonDecode(response.body);
        List<UserModel> users = jsonResponse.map((user) => UserModel.fromJson(user)).toList();
        return users;
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load users');
      }
    } catch (e) {
      // Handle errors here, and return an empty list in case of an error.
      print('Error fetching users: $e');
      return [];
    }
  }

  static Future<PostModel?> createPost(PostModel post) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(post.toJson()),
      );

      if (response.statusCode == 201) {
        // Post created successfully
        return PostModel.fromJson(jsonDecode(response.body));
      } else {
        // Failed to create post
        return null;
      }
    } catch (e) {
      // Handle errors here
      print('Error creating post: $e');
      return null;
    }
  }
}
