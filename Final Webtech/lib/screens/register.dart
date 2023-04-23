import '../utils/exports.dart';

// A screen that allows users to register.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController id = TextEditingController();
  String major = '';
  String classYear = '';

  TextEditingController dob = TextEditingController();
  TextEditingController bestFood = TextEditingController();
  TextEditingController bestMovie = TextEditingController();

  // A list of available majors.
  static const majorsList = ["BS", "CS", "MIS", "CE", "ME", "Select Major"];
  int majorInt = 6;

  // A list of available class years.
  final classList = ["2023", "2024", "2025", "2026", "Other", "Select Class"];
  int classInt = 6;

  // Whether the have on-campus or off-campus residence
  bool onCampus = false;
  bool offCampus = false;

  bool validationError = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appBarColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Constants.size.width > 850 ? 20.w : 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 30),
                child: Text(appName, style: TextStyles.button),
              ),
              // The error message if any
              AnimatedCrossFade(
                firstChild: const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Please fill all fields",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Color.fromARGB(255, 148, 148, 148),
                    ),
                  ),
                ),
                secondChild: const SizedBox.shrink(),
                crossFadeState: validationError
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Sign Up", style: TextStyles.title),
              ),
              // The name text field
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: FormWidget(
                  lableText: "Full Name",
                  controller: name,
                  validator: FormBuilderValidators.compose(
                    [
                      if (validationError) ...[
                        FormBuilderValidators.required(
                            errorText: "Name is required".tr),
                      ],
                    ],
                  ),
                ),
              ),
              // The email text field
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: FormWidget(
                  lableText: "Email",
                  controller: email,
                  validator: FormBuilderValidators.compose(
                    [
                      if (validationError) ...[
                        FormBuilderValidators.required(
                            errorText: "Email is required".tr),
                        FormBuilderValidators.email(
                            errorText: "Email is not valid".tr),
                      ],
                    ],
                  ),
                ),
              ),
              // The date of birth text field
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    // The date picker
                    showDatePicker(
                      context: context,
                      initialDate: DateTime(2010, 1, 1),
                      lastDate: DateTime(2010),
                      firstDate: DateTime(1950),
                    ).then((value) {
                      setState(() {
                        dob.text = Utilities.dateFormat(value!);
                      });
                    });
                  },
                  child: FormWidget(
                    enabled: false,
                    lableText: "Date of Birth",
                    controller: dob,
                    validator: FormBuilderValidators.compose(
                      [
                        if (validationError) ...[
                          FormBuilderValidators.required(
                              errorText: "This field is required".tr),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              // The id text field
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: FormWidget(
                  lableText: "ID",
                  controller: id,
                  validator: FormBuilderValidators.compose(
                    [
                      if (validationError) ...[
                        FormBuilderValidators.required(
                            errorText: "Id is required".tr),
                        FormBuilderValidators.numeric(
                            errorText: "ID is not valid".tr),
                        FormBuilderValidators.minLength(8,
                            errorText: "ID is not valid".tr),
                        FormBuilderValidators.maxLength(8,
                            errorText: "ID is not valid".tr)
                      ],
                    ],
                  ),
                ),
              ),
              // The best food text field
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: FormWidget(
                  lableText: "Best Food",
                  controller: bestFood,
                  validator: FormBuilderValidators.compose(
                    [
                      if (validationError) ...[
                        FormBuilderValidators.required(
                            errorText: "This field is required".tr),
                      ],
                    ],
                  ),
                ),
              ),
              // The best movie text field
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 15),
                child: FormWidget(
                  lableText: "Best Movie",
                  controller: bestMovie,
                  validator: FormBuilderValidators.compose(
                    [
                      if (validationError) ...[
                        FormBuilderValidators.required(
                            errorText: "This field is required".tr),
                      ],
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Major",
                    style: TextStyles.button,
                  ),
                  const SizedBox(width: 20),
                  // The dropdown button for selecting a major
                  MajorDropdown(
                    color: Colors.black,
                    textStyle: TextStyles.body,
                    onTap: (val) {
                      setState(() {
                        majorInt = val;
                        major = majorsList[val - 1];
                      });
                    },
                    majorInt: majorInt,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    "Class",
                    style: TextStyles.button,
                  ),
                  const SizedBox(width: 20),
                  // The dropdown button for selecting a class
                  ClassDropDown(
                    color: Colors.black,
                    textStyle: TextStyles.body,
                    onTap: (val) {
                      setState(() {
                        classInt = val;
                        classYear = classList[val - 1];
                      });
                    },
                    classInt: classInt,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "On-Campus",
                        style: TextStyles.button,
                      ),
                      // The checkbox for selecting on campus
                      Checkbox(
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                          value: onCampus,
                          onChanged: (val) {
                            setState(() {
                              onCampus = val!;
                              offCampus = !val;
                            });
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Off-Campus",
                        style: TextStyles.button,
                      ),
                      // The checkbox for selecting off campus
                      Checkbox(
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                          value: offCampus,
                          onChanged: (val) {
                            setState(() {
                              offCampus = val!;
                              onCampus = !val;
                            });
                          }),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // The login button that takes the user to the login screen
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      onPressed: () {
                        Get.off(() => const LoginScreen());
                      },
                      color: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.all(16),
                      height: 40,
                      minWidth: 140,
                      child: const Text("Login", style: TextStyles.button),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  // The sign up button
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      onPressed: () {
                        validateForms();
                      },
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: const BorderSide(
                            color: Color(0xff9e9e9e), width: 1),
                      ),
                      padding: const EdgeInsets.all(16),
                      height: 40,
                      minWidth: 140,
                      // The loading indicator
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 4,
                              ),
                            )
                          : const Text("Sign Up",
                              style: TextStyles.buttonBlack),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  // The function that validates the forms and creates the user
  void validateForms() async {
    // Validates the user inputs
    if (email.text.isEmail &&
        name.text.isNotEmpty &&
        bestFood.text.isNotEmpty &&
        bestMovie.text.isNotEmpty &&
        majorInt != 7 &&
        classInt != 6 &&
        (onCampus || offCampus) &&
        dob.text.isNotEmpty &&
        id.text.isNotEmpty &&
        id.text.isNumericOnly &&
        id.text.length == 8) {
      setState(() {
        validationError = false;
        isLoading = true;
      });
      try {
        // Creates the user with email and id as password
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: id.text)
            .then((value) {
          setState(() {
            isLoading = false;
          });
          // Navigates to the feed page
          Get.offAll(() => const FeedPage());
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        // Shows the error message if any
        Fluttertoast.showToast(
          msg: e.toString().split("] ")[1],
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14,
        );
      }
      // Save the user to the database
      final DocumentReference docReference =
          FirebaseFirestore.instance.collection("users").doc(id.text);
      final AppUser newUser = AppUser(
          name: name.text,
          email: email.text,
          bestFood: bestFood.text,
          bestMovie: bestMovie.text,
          major: major,
          year: classYear,
          onCampus: onCampus,
          dob: dob.text,
          id: id.text);
      FirebaseFirestore.instance
          .runTransaction((transaction) => docReference.set(newUser.toJson()))
          .whenComplete(() {
        user.value = newUser;
        final userString = jsonEncode(user.value.toJson());
        prefs!.setString('user', userString);
      });
    } else {
      setState(() {
        validationError = true;
      });
    }
  }
}
