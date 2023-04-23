import 'package:ashesi_social/utils/exports.dart';

// This widget is used to display a post in the feed
class FeedContainer extends StatelessWidget {
  const FeedContainer({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Get.to(() => VeiwProfile(
                  withID: true,
                  id: post.authorID,
                )),
            child: Row(
              children: [
                // The image of the user who posted the post
                ImageContainer(
                  imageURL: post.authorImage ??
                      "https://firebasestorage.googleapis.com/v0/b/daafua-ashesi-social.appspot.com/o/9-250x250.jpg?alt=media&token=5a0798b0-f565-4e63-99cc-eb52e0f3167c",
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The name of the user who posted the post
                      Text(
                        post.author!,
                        style: TextStyles.buttonBlack,
                      ),
                      // The time since the post was posted
                      Text(
                        post.date == null
                            ? ''
                            : Utilities.timeSincePost(post.date!),
                        style: TextStyles.bodysmallSubTitleB,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            // The text of the post
            child: Text(
              post.text!,
              style: TextStyles.bodyBlack,
            ),
          ),
          // The image of the post if any
          post.image == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Image(
                    image: NetworkImage(post.image!),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
        ],
      ),
    );
  }
}

// This widget is used to display the image of a post
class ImageContainer extends StatelessWidget {
  // The height of the image
  final double? height;
  // The width of the image
  final double? width;
  // The url of the image
  final String imageURL;
  const ImageContainer(
      {required this.imageURL, this.width, super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      width: width ?? 60,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.network(imageURL, fit: BoxFit.cover),
    );
  }
}
