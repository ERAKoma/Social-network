import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  //define variables to hold user details
  String? _studentId,
      _name,
      _email,
      _dob,
      _yearGroup,
      _major,
      _bestFood,
      _bestMovie;
  bool _hasCampusResidence = false;

  final _formKey = GlobalKey<FormState>(); //form key to validate input fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Profile"),
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
                  decoration: InputDecoration(labelText: "Student ID"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your student ID";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _studentId = newValue;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _name = newValue;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains("@")) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _email = newValue;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Date of Birth"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your date of birth";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _dob = newValue;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Year Group"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your year group";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _yearGroup = newValue;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Major"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your major";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _major = newValue;
                  },
                ),
                Row(
                  children: [
                    Text("Do you have campus residence?"),
                    Switch(
                      value: _hasCampusResidence,
                      onChanged: (value) {
                        setState(() {
                          _hasCampusResidence = value;
                        });
                      },
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Best Food"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your best food";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _bestFood = newValue;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Best Movie"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your best movie";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _bestMovie = newValue;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
