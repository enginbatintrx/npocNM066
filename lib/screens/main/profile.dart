import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:npocnm/models/post.dart';
import 'package:npocnm/server/firebase_auth.dart';
import 'package:npocnm/server/helper.dart';
import 'package:npocnm/utils/feedprofAppBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/postCard.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Helper helper = Helper();
  firebaseAuth auth = firebaseAuth();
  bool isDataLoaded = false;

  Future<void> fetchDataAndLoadPosts() async {
    await helper.fetchAllPosts();
    await helper.loadFavoritePosts();
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    if (!isDataLoaded) {
      fetchDataAndLoadPosts();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: feedAppBar(
        context,
        IconButton(
          onPressed: () {
            auth.logout();
            Navigator.pushNamed(context, '/');
          },
          icon: Icon(
            Icons.logout,
            color: Colors.black,
            size: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Divider(),
            margin: EdgeInsets.fromLTRB(60, 15, 60, 15),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.favs,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await helper.removeAllFavoritePosts();
                    setState(() {});
                  },
                  child: Text(
                    AppLocalizations.of(context)!.clear,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: helper.favoritePosts.length,
              itemBuilder: (context, index) {
                Post post = helper.favoritePosts[index];
                return PostCard(
                  postId: post.postId!,
                  subtitle: post.subtitle,
                  commentnumber: post.comments!.length,
                  color: post.color!,
                  title: post.title,
                  index: 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
