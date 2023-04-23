import 'package:cloud_firestore/cloud_firestore.dart';


// Serialize and deserialize a post data from Firestore
class Post {
  final String? text;
  final String? image;
  final String? author;
  final Timestamp? date;
  final String? authorImage;
  final String? authorID;

  Post({this.author, this.date, this.image, this.text, this.authorImage, this.authorID});

// A factory method to create a Post instance from a JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      text: json['text'],
      image: json['image'],
      author: json['author'],
      date: json['date'],
      authorImage: json['authorImage'],
      authorID: json['authorID'],
    );
  }

// A method to serialize a Post instance into a JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'image': image,
      'author': author,
      'date': date,
      'authorImage': authorImage,
      'authorID': authorID,
    };
  }
}
