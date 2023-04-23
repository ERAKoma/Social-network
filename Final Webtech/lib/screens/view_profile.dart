import '../utils/exports.dart';

// A page to display the user's profile information and the profile of other users
class VeiwProfile extends StatefulWidget {
  // Whether the user is viewing their own profile or another user's profile
  final bool withID;
  // The ID of the user whose profile is being viewed
  final String? id;
  const VeiwProfile({super.key, required this.withID, this.id});

  @override
  State<VeiwProfile> createState() => _VeiwProfileState();
}

class _VeiwProfileState extends State<VeiwProfile> {
  // The user's date of birth
  TextEditingController dob = TextEditingController();
  // The user's favorite food
  TextEditingController bestFood = TextEditingController();
  // The user's favorite movie
  TextEditingController bestMovie = TextEditingController();
  // The user's name
  TextEditingController name = TextEditingController();
  // The user's email
  TextEditingController email = TextEditingController();
  // The user's student ID
  TextEditingController studentID = TextEditingController();
  // The user's class year
  TextEditingController classYear = TextEditingController();
  // The user's major
  TextEditingController major = TextEditingController();
  // The user's residence
  TextEditingController residence = TextEditingController();

  AppUser? appUser;

  @override
  void initState() {
    if (widget.withID) {
      getUser();

      if (appUser != null) {}
    } else {
      // pre-populate the fields with the user's information
      dob.text = user.value.dob!;
      bestFood.text = user.value.bestFood!;
      bestMovie.text = user.value.bestMovie!;
      name.text = user.value.name!;
      email.text = user.value.email!;
      studentID.text = user.value.id!;
      classYear.text = user.value.year!;
      major.text = user.value.major!;
      residence.text = user.value.onCampus == true ? "On-Campus" : "Off-Campus";
    }

    super.initState();
  }

// Get the user's information from the database and update the fields.
// This is only called when the user is viewing another user's profile
  void getUser() async {
    appUser = await Services.getAnyUser(widget.id!);
    setState(() {
      dob.text = appUser!.dob!;

      bestFood.text = appUser!.bestFood!;
      bestMovie.text = appUser!.bestMovie!;
      name.text = appUser!.name!;
      email.text = appUser!.email!;
      studentID.text = appUser!.id!;
      classYear.text = appUser!.year!;
      major.text = appUser!.major!;
      residence.text = appUser!.onCampus == true ? "On-Campus" : "Off-Campus";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        backgroundColor: Constants.appBarColor,
        title: const Text("Profile", style: TextStyles.title),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xffffffff),
            size: 30,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: widget.withID && appUser == null
          ? const Center(
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: Colors.black,
                  )),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.size.width > 850 ? 20.w : 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // The user's name
                    FormWidget(
                      enabled: false,
                      lableText: "Name",
                      controller: name,
                      textStyle: TextStyles.bodyBlack,
                    ),
                    const SizedBox(height: 16),
                    // The user's email
                    FormWidget(
                      enabled: false,
                      lableText: "Email",
                      controller: email,
                      textStyle: TextStyles.bodyBlack,
                    ),
                    const SizedBox(height: 16),
                    // The user's date of birth. This is only shown if the user is viewing their own profile
                    widget.withID && user.value.id != appUser!.id
                        ? SizedBox.fromSize()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: FormWidget(
                              enabled: false,
                              lableText: "Date of Birth",
                              controller: dob,
                              textStyle: TextStyles.bodyBlack,
                            ),
                          ),
                    // The user's id. This is only shown if the user is viewing their own profile
                    widget.withID && user.value.id != appUser!.id
                        ? SizedBox.fromSize()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: FormWidget(
                              enabled: false,
                              lableText: "Student ID",
                              controller: studentID,
                              textStyle: TextStyles.bodyBlack,
                            ),
                          ),
                    // The user's major
                    FormWidget(
                      enabled: false,
                      lableText: "Major",
                      controller: major,
                      textStyle: TextStyles.bodyBlack,
                    ),
                    const SizedBox(height: 16),
                    // The user's class year
                    FormWidget(
                      enabled: false,
                      lableText: "Class",
                      controller: classYear,
                      textStyle: TextStyles.bodyBlack,
                    ),
                    const SizedBox(height: 16),
                    // The user's best food
                    FormWidget(
                      enabled: false,
                      lableText: "Best Food",
                      controller: bestFood,
                      textStyle: TextStyles.bodyBlack,
                    ),
                    const SizedBox(height: 16),
                    // The user's residence
                    FormWidget(
                      enabled: false,
                      lableText: "Residence",
                      controller: residence,
                      textStyle: TextStyles.bodyBlack,
                    ),
                    const SizedBox(height: 16),
                    // The user's best movie
                    FormWidget(
                      enabled: false,
                      lableText: "Best Movie",
                      controller: bestMovie,
                      textStyle: TextStyles.bodyBlack,
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
    );
  }
}
