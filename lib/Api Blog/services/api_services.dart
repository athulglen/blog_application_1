import 'package:blog_application_1/Api%20Blog/model/post_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:blog_application_1/Api%20Blog/model/user_model.dart';
import 'package:blog_application_1/Api%20Blog/model/comment_model.dart';

class HttpService {
  static Future<List<PostModel>> fetchPosts() async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      var data = response.body;
      return postModelFromJson(data);
    } else {
      throw Exception();
    }
  }

  static Future<List<UserModel>?> fetchUser(int userId) async {
    try{
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users/$userId"));
    if (response.statusCode == 200) {
      var data = response.body;
      return userModelFromJson(data);
    } else {
      throw Exception();
    }
  }catch(e){
    print('Error fetching user: $e');
    return null;
  }
}

  static Future<List<CommentModel>> fetchComments(int postId) async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId/comments"));
    if (response.statusCode == 200) {
      var data = response.body;
      return commentModelFromJson(data);
    } else {
      throw Exception();
    }
  }
}
