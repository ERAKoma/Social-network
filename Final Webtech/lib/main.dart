import 'dart:convert';

import 'package:ashesi_social/screens/login.dart';
import 'package:ashesi_social/utils/constants.dart';
import 'package:ashesi_social/utils/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'models/user.dart';
import 'screens/feed.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  prefs = await SharedPreferences.getInstance();

  final userString = prefs!.getString('user');
  if (userString != null) {
    user.value = AppUser.fromJson(jsonDecode(userString));
    Services.getUser(user.value.id!);
  }
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: user == null ? const LoginScreen() : const FeedPage(),
        );
      },
      maxTabletWidth: 900,
    );
  }
}
