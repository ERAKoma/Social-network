// ignore_for_file: library_private_types_in_public_api

import "dart:convert";
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

  final cloudURL = Uri.parse(
      "https://us-central1-webtech54212024.cloudfunctions.net/create_post");
  Future<void> createPost() async {
    final payload = json.encode({
      "email": emailController.text,
      "content": contentController.text,
    });
    final response = await http.post(cloudURL, body: payload);
    // final response = await http.post(
    //   Uri.parse("https://us-central1-webtech54212024.cloudfunctions.net/create_post"),
    //   body: {
    //     "email": emailController.text,
    //     "content": contentController.text,
    //   },
    // );
    // if (response.statusCode == 200) {
    //   // post created successfully
    //   // ignore: use_build_context_synchronously
    //   Navigator.pop(context);
    // } else {
    //   // handle error
    // }
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
