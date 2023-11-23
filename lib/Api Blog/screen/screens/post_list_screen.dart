import 'package:blog_application_1/Api%20Blog/controller/postcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blog_application_1/Api%20Blog/services/api_services.dart';

class PostListScreen extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Posts'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => DropdownButton(
                hint: Text('Select User'),
                value: postController.selectedUser.value,
                items: [
                  DropdownMenuItem(
                    child: Text('All Users'),
                    value: null,
                  ),
                  for (var user in postController.users)
                    DropdownMenuItem(
                      child: Text(user.name ?? ''),
                      value: user.id,
                    ),
                ],
                onChanged: (value) {
                  postController.selectedUser.value = value;
                  postController.getPosts();
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (postController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: postController.postList.length,
                    itemBuilder: (context, index) {
                      var post = postController.postList[index];
                      return Dismissible(
                        key: Key(post.id.toString()),
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          postController.deletePost(post.id);
                        },
                        child: ListTile(
                          title: Text(post.title ?? ''),
                          subtitle: Text(post.body ?? ''),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
