// create_post_screen.dart

import 'package:blog_application_1/Api%20Blog/model/post_model.dart';
import 'package:blog_application_1/Api%20Blog/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'http_service.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  var selectedUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: bodyController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            SizedBox(height: 16),
            UserDropdown(
              selectedUserId: selectedUserId,
              onChanged: (value) {
                setState(() {
                  selectedUserId = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                createPost();
              },
              child: Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }

  void createPost() async {
    if (titleController.text.isNotEmpty &&
        bodyController.text.isNotEmpty &&
        selectedUserId != null) {
      var newPost = PostModel(
        userId: selectedUserId,
        title: titleController.text,
        body: bodyController.text,
      );

      var createdPost = await HttpService.createPost(newPost);

      if (createdPost != null) {
        Get.snackbar('Success', 'Post created successfully');
        // Optionally, you can navigate back to the home screen or perform any other actions.
      } else {
        Get.snackbar('Error', 'Failed to create post');
      }
    } else {
      Get.snackbar('Error', 'Please fill in all fields');
    }
  }
}

class UserDropdown extends StatelessWidget {
  final int? selectedUserId;
  final ValueChanged<int?> onChanged;

  UserDropdown({
    required this.selectedUserId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: HttpService.fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var users = snapshot.data!;
          return DropdownButton(
            hint: Text('Select User'),
            value: selectedUserId,
            items: users.map((user) {
              return DropdownMenuItem(
                child: Text(user.name ?? ''),
                value: user.id,
              );
            }).toList(),
            onChanged: onChanged,
          );
        }
      },
    );
  }
}
