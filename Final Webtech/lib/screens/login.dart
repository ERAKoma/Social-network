import '../utils/exports.dart';

// A page to login by email and student id
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController id = TextEditingController();
  TextEditingController email = TextEditingController();

  bool validationError = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appBarColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: Constants.size.width > 850 ? 20.w : 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 30),
                child: Text(appName, style: TextStyles.button),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign In",
                  style: TextStyles.title,
                ),
              ),
              // The email text field
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                child: FormWidget(
                  controller: email,
                  lableText: "Email",
                  validator: FormBuilderValidators.compose(
                    [
                      if (validationError) ...[
                        FormBuilderValidators.required(
                            errorText: "Eamil is required".tr),
                        FormBuilderValidators.email(
                            errorText: "Email is not valid".tr),
                      ],
                    ],
                  ),
                ),
              ),
              // The student id text field
              FormWidget(
                controller: id,
                lableText: "Student ID",
                validator: FormBuilderValidators.compose(
                  [
                    if (validationError) ...[
                      FormBuilderValidators.required(
                          errorText: "Id is required".tr),
                      FormBuilderValidators.numeric(
                          errorText: "ID is not valid".tr),
                      FormBuilderValidators.minLength(8,
                          errorText: "ID is not valid".tr),
                      FormBuilderValidators.minLength(8,
                          errorText: "ID is not valid".tr)
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // The login button
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          validateForms();
                        },
                        color: const Color(0xffffffff),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: const BorderSide(
                              color: Color(0xff9e9e9e), width: 1),
                        ),
                        padding: const EdgeInsets.all(16),
                        height: 40,
                        minWidth: 140,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                //padding: EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 4,
                                ),
                              )
                            : const Text("Login",
                                style: TextStyles.buttonBlack),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          Get.off(() => const RegisterScreen());
                        },
                        color: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.all(16),
                        height: 40,
                        minWidth: 140,
                        child: const Text("Sign Up", style: TextStyles.button),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Validates the user inputs and logs the user in
  void validateForms() async {
    if (email.text.isEmail &&
        id.text.isNotEmpty &&
        id.text.isNumericOnly &&
        id.text.length == 8) {
      setState(() {
        validationError = false;
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email.text, password: id.text)
            .then((value) async {
          await Services.getUser(id.text);

          setState(() {
            isLoading = false;
          });
          Get.offAll(() => const FeedPage());
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
          msg: "No user found with the given credentials",
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
