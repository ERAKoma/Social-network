import '../utils/exports.dart';

// A page to show the feed of posts
class FeedPage extends StatefulWidget {
  const FeedPage({Key? key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<QueryDocumentSnapshot> posts = [];
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Feed'),
    Text('Add'),
    Text('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Get.to(() => const NewPost());
    } else if (index == 2) {
      Get.to(() => const EditProfile());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      // The app bar
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        backgroundColor: Constants.appBarColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Feed",
          style: TextStyles.title,
        ),
      ),
      // A stream builder to show the posts in real time
      body: StreamBuilder(
          stream: Services().getPosts(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              posts = snapshot.data!.docs;
            }
            if (posts.isNotEmpty) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: Constants.size.width > 850 ? 20.w : 10.w),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  final post = Post.fromJson(snapshot.data!.docs[index].data());
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: FeedContainer(post: post),
                  );
                },
              );
            } else {
              return const Center(child: Text("No posts yet"));
            }
          }),
      // The bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Constants.appBarColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
