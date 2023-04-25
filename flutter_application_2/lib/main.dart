import "package:flutter/material.dart";
import "package:cloud_functions/cloud_functions.dart";
import 'feed.dart';
import "user_creation.dart";
import "posts_creation.dart";

void main() {
  runApp(MyApp());
}

FirebaseFunctions functions = FirebaseFunctions.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Social Network App"),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: "Posts"),
                Tab(text: "User Creation"),
                Tab(text: "Post Creation")
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              PostsPage(),
              CreateUserPage(),
              CreatePostPage(),
            ],
          ),
        ),
      ),
    );
  }
}
