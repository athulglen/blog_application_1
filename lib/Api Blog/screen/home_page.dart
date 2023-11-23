import 'package:blog_application_1/Api%20Blog/model/post_model.dart';
import 'package:blog_application_1/Api%20Blog/screen/screens/create_post_screen.dart';
import 'package:blog_application_1/Api%20Blog/screen/screens/post_details_screen.dart';
import 'package:blog_application_1/Api%20Blog/screen/screens/post_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder PostModel instance for demonstration
    var specificPost = PostModel(
      userId: 1,
      id: 1,
      title: 'Sample Title',
      body: 'Sample Body',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Application'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePostScreen()),
                );
              },
              child: Text('Create Post'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailsScreen(
                      post: specificPost,
                    ),
                  ),
                );
              },
              child: Text('View Post Details'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostListScreen()),
                );
              },
              child: Text('View Blog Posts'),
            ),
          ],
        ),
      ),
    );
  }
}
