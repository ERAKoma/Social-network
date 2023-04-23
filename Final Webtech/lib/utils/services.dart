import 'package:ashesi_social/utils/exports.dart';

// This class is used to handle operations on the database
class Services {
  // This function is used to get the current user from the database
  static Future<void> getUser(String userID) async {
    final userReference =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    if (userReference.exists && userReference.data() != null) {
      // Replace the user object with the new user object
      user.value = AppUser.fromJson(userReference.data()!);
      final userString = jsonEncode(userReference.data()!);
      prefs!.setString('user', userString);
    }
  }

// This function is used to get any user from the database
  static Future<AppUser?> getAnyUser(String userID) async {
    var aUser = AppUser();
    final userReference =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    if (userReference.exists && userReference.data() != null) {
      aUser = AppUser.fromJson(userReference.data()!);

      return aUser;
    } else {
      return null;
    }
  }

// This function is used to upload a file to firebase storage.
// It returns a download url for the file
  Future<String> uploadFile(File image) async {
    if (kIsWeb) {
      String downloadURL;
      Reference reference =
          FirebaseStorage.instance.ref().child('media/${image.path}');
      await reference
          .putData(
            await XFile(image.path).readAsBytes(),
          )
          .whenComplete(() async {});
      downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } else {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('media/${image.path}');
      UploadTask uploadTask = storageReference.putFile(image);

      uploadTask.snapshotEvents
          .listen((TaskSnapshot snapshot) {}, onError: (e) {}, onDone: () {});

      await uploadTask.whenComplete(() => null);

      return await storageReference.getDownloadURL();
    }
  }

// This function is used to get stream snapshots of all the posts in the database
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .snapshots();
  }
}
