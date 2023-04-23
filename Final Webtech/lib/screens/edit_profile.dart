import '../utils/exports.dart';

// This is a page for editing the user's profile

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String major = '';
  String classYear = '';

  TextEditingController dob = TextEditingController();
  TextEditingController bestFood = TextEditingController();
  TextEditingController bestMovie = TextEditingController();

  // final majorsList = ["BS", "CS", "MIS", "CE", "EE", "ME", "Selecr Major"];
  // int majorInt = 7;
  // final classList = ["2023", "2024", "2025", "2026", "Other", "Selecr Class"];
  // int classInt = 6;

// whether there is a validation error or not
  bool validationError = false;

// Whether the user is off campus or not
  bool offCampus = false;
  bool onCampus = false;
  bool isLoading = false;

  @override
  void initState() {
    // Populate the user data into the various textfields for editing.
    dob.text = user.value.dob!;
    bestFood.text = user.value.bestFood!;
    bestMovie.text = user.value.bestMovie!;
    major = user.value.major!;
    classYear = user.value.year!;

    onCampus = user.value.onCampus!;
    offCampus = !user.value.onCampus!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The app bar
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        backgroundColor: Constants.appBarColor,
        title: const Text("Edit Profile", style: TextStyles.title),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 30,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      // The body of the page
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Constants.size.width > 850 ? 20.w : 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              AnimatedCrossFade(
                firstChild: const Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 16),
                  child: Text(
                    "Please fill all fields correctly",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Color(0xff9e9e9e),
                    ),
                  ),
                ),
                secondChild: const SizedBox.shrink(),
                crossFadeState: validationError
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
              ),
              // Date of birth textfield
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime(2010, 1, 1),
                      lastDate: DateTime(2010),
                      firstDate: DateTime(1950),
                    ).then((value) {
                      setState(() {
                        if (value != null) {
                          dob.text = Utilities.dateFormat(value);
                        }
                      });
                    });
                  },
                  child: FormWidget(
                    enabled: false,
                    lableText: "Date of Birth",
                    controller: dob,
                    textStyle: TextStyles.bodyBlack,
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
              // Best food textfield
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: FormWidget(
                  lableText: "Best Food",
                  controller: bestFood,
                  textStyle: TextStyles.bodyBlack,
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
              // Best movie textfield
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 15),
                child: FormWidget(
                  lableText: "Best Movie",
                  controller: bestMovie,
                  textStyle: TextStyles.bodyBlack,
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

              // Checkbox for on campus and off campus
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "On-Campus",
                        style: TextStyles.buttonBlack,
                      ),
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
                        style: TextStyles.buttonBlack,
                      ),
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

              // Update button
              MaterialButton(
                onPressed: () {
                  if (!isLoading) {
                    validateForms();
                  }
                },
                color: Constants.appBarColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.all(16),
                height: 40,
                minWidth: Constants.size.width,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        //padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 4,
                        ),
                      )
                    : const Text("Update", style: TextStyles.button),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

// Function to validate the forms and update the user details
  void validateForms() async {
    // Check if all the fields are filled correctly
    if (bestFood.text.isNotEmpty &&
        bestMovie.text.isNotEmpty &&
        (onCampus || offCampus) &&
        dob.text.isNotEmpty) {
      setState(() {
        validationError = false;
        isLoading = true;
      });
      try {
        // update the user details in the locally and in firestore
        user.value.bestFood = bestFood.text;
        user.value.bestMovie = bestMovie.text;
        user.value.major = major;
        user.value.year = classYear;
        user.value.onCampus = onCampus;
        //user.value.offCampus = offCampus;
        user.value.dob = dob.text;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.value.id)
            .update(user.toJson());
        setState(() {
          isLoading = false;
        });
        // show show update success message
        Fluttertoast.showToast(
          msg: "Profile Updated",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14,
        );
        Get.back();
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        // show update error message
        Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14,
        );
      }
    } else {
      setState(() {
        validationError = true;
      });
    }
  }
}
