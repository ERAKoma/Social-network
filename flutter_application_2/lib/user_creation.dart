import "dart:convert";
import "dart:io";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State {
  //define textediting controllers to hold user details
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _yearGroupController = TextEditingController();
  final TextEditingController _hasCampusResidenceController =
      TextEditingController();
  final TextEditingController _bestFoodController = TextEditingController();
  final TextEditingController _bestMovieController = TextEditingController();

  final cloudURL = Uri.parse("https://webtech54212024.uc.r.appspot.com/users");
  final headers = {HttpHeaders.contentTypeHeader: "application/json"};
  Future<void> createUser() async {
    final body = json.encode({
      "name": _nameController.text,
      "dob": _dobController.text,
      "email": _emailController.text,
      "major": _majorController.text,
      "yearGroup": _yearGroupController.text,
      "hasCampusResidence": _hasCampusResidenceController.text,
      "bestFood": _bestFoodController.text,
      "bestMovie": _bestMovieController.text,
    });
    try {
      final response = await http.post(cloudURL, headers: headers, body: body);
      if (response.statusCode == 200) {
        // Handle successful response here
      } else {
        throw Exception('Failed to create user');
      }
    } catch (error) {
      // Handle error here
    }
  }

  final _formKey = GlobalKey<FormState>(); //form key to validate input fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(labelText: "Date of Birth"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your date of birth";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains("@")) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _majorController,
                  decoration: const InputDecoration(labelText: "Major"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your major";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _yearGroupController,
                  decoration: const InputDecoration(labelText: "Year Group"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your year group";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _hasCampusResidenceController,
                  decoration: const InputDecoration(labelText: "Residence"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Are you on campus or off campus?";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bestFoodController,
                  decoration: const InputDecoration(labelText: "Best Food"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your best food";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bestMovieController,
                  decoration: const InputDecoration(labelText: "Best Movie"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your best movie";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
