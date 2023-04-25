import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State {
  List<Map<String, dynamic>> posts = [];

  Future fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://webtech54212024.uc.r.appspot.com/posts'));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List;
      setState(() {
        posts = responseData.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(post['content']),
              subtitle: Text(post['email']),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
