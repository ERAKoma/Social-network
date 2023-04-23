import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// A file to store utility functions used throughout the app
class Utilities {
  // A function to format a date
  static String dateFormat(DateTime date) {
    return DateFormat("d-MMM-yyyy").format(date);
  }

// A function to format a time since a post was made
  static String timeSincePost(Timestamp milliseconds){
    DateTime date = milliseconds.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);
    if(difference.inDays > 7){
      return dateFormat(date);
    }else if(difference.inDays > 1){
      return "${difference.inDays} days ago";
    }else if(difference.inHours > 0){
      return "${difference.inHours} hrs ago";
    }else if(difference.inMinutes > 1){
      return "${difference.inMinutes} mins ago";
    }else{
      return "Just now";
    }
  }
}
