import 'package:flutter/material.dart';
import 'package:blog_application_1/Api%20Blog/model/comment_model.dart';
import 'package:blog_application_1/Api%20Blog/model/post_model.dart';
import 'package:blog_application_1/Api%20Blog/model/user_model.dart';
import 'package:blog_application_1/Api%20Blog/services/api_services.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostModel post;

  PostDetailsScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostInfo(post),
            SizedBox(height: 16),
            _buildUserDetails(post),
            SizedBox(height: 16),
            _buildCommentsSection(post),
          ],
        ),
      ),
    );
  }

  Widget _buildPostInfo(PostModel post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title ?? '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          post.body ?? '',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildUserDetails(PostModel post) {
    return FutureBuilder<UserModel?>(
  future: null,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      var user = snapshot.data;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (user != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${user.name ?? ''}'),
                Text('Email: ${user.email ?? ''}'),
                Text('Username: ${user.username ?? ''}'),
              ],
            ),
        ],
      );
    }
  },
);

  }

  Widget _buildCommentsSection(PostModel post) {
    return FutureBuilder<List<CommentModel>>(
      future: HttpService.fetchComments(post.id.toString() as int),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var comments = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Comments:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    var comment = comments[index];
                    return ListTile(
                      title: Text(comment.name ?? ''),
                      subtitle: Text(comment.body ?? ''),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
