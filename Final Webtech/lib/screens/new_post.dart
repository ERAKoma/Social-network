import '../utils/exports.dart';

// A page to create a new post
class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  TextEditingController post = TextEditingController();
  TextEditingController email = TextEditingController();


  bool validationError = false;
  bool isLoading = false;

  // The map to save the post
  Map<String, dynamic> postMap = {};

  @override
  void initState() {
    super.initState();
    email.text = user.value.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // The app bar
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        backgroundColor: Constants.appBarColor,
        title: const Text("New Post", style: TextStyles.title),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Constants.size.width > 850 ? 20.w : 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                // The post text field
                child: TextFormField(
                  controller: post,
                  maxLines: null,
                  onChanged: (val) {
                    setState(() {
                      post.text = val;
                      post.selection =
                          TextSelection.collapsed(offset: post.text.length);
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter text",
                    hintStyle: TextStyle(color: Colors.black38),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              // The validation error
              AnimatedCrossFade(
                firstChild: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    post.text.isEmpty
                        ? "Post is required".tr
                        : " < 10 characters".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ),
                secondChild: const SizedBox.shrink(),
                crossFadeState: validationError &&
                        (post.text.isEmpty || post.text.length < 10)
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 300),
              ),
              // The email text field
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                ),
                child: FormWidget(
                  textStyle: TextStyles.bodyBlack,
                  lableText: "Email",
                  controller: email,
                  errorStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 12,
                    color: Colors.red,
                  ),
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
              // The post button
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
                child: MaterialButton(
                  onPressed: () {
                    if (!isLoading) {
                      validateForms();
                    }
                  },
                  color: const Color.fromARGB(255, 73, 26, 25),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: const BorderSide(color: Color.fromARGB(255, 123, 122, 122), width: 1),
                  ),
                  padding: const EdgeInsets.all(16),
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  height: Constants.size.width > 800 ? 60 : 40,
                  minWidth: MediaQuery.of(context).size.width,
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
                      : const Text(
                          "Post",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // The function that validates the forms and posts the data to the database
  void validateForms() async {
    // Validate the input fields
    if (post.text.isNotEmpty && email.text.isEmail && post.text.length > 10) {
      setState(() {
        validationError = false;
        isLoading = true;
      });
      // Add the post to the database
      postMap = {
        "text": post.text,
        "author": user.value.name,
        "date": FieldValue.serverTimestamp(),
        "authorID": user.value.id,
      };
      FirebaseFirestore.instance
          .collection('posts')
          .add(postMap)
          .then((value) => Get.offAll(() => const FeedPage()));
    } else {
      // Add the post to the database if no image is picked
      postMap = {
        "text": post.text,
        "author": user.value.name,
        "date": FieldValue.serverTimestamp(),
        "authorID": user.value.id,
      };
      FirebaseFirestore.instance
          .collection('posts')
          .add(postMap)
          .then((value) => Get.offAll(() => const FeedPage()));
    }
    setState(() {
      isLoading = false;
    });
  }
}
