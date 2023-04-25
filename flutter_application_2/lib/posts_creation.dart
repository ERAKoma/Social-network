// ignore_for_file: library_private_types_in_public_api
import "dart:convert";
import "dart:io";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  final cloudURL = Uri.parse("https://webtech54212024.uc.r.appspot.com/posts");
  final headers = {HttpHeaders.contentTypeHeader: "application/json"};
  Future<void> createPost() async {
    final body = json.encode({
      "email": emailController.text,
      "content": contentController.text,
    });
    try {
      final response = await http.post(cloudURL, headers: headers, body: body);
      if (response.statusCode == 200) {
        // Show success alert
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Success"),
              content: const Text("Post created successfully!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Failed to create post');
      }
    } catch (error) {
      // Handle error here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contentController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "What's on your mind?",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => createPost(),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
