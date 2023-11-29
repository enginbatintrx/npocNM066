import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:npocnm/models/post.dart';
import 'package:npocnm/server/firebase_post.dart';
import 'package:npocnm/server/helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostDetail extends StatefulWidget {
  Post post;
  String? postId;
  int index;
  PostDetail({super.key, required this.index, this.postId, required this.post});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  firebasePost posts = firebasePost();
  Helper helper = Helper();
  @override
  Widget build(BuildContext context) {
    Post post = Post(
      subtitle: widget.post.subtitle,
      title: widget.post.title,
      postId: widget.postId,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await helper.addFavoritePost(post);
              print(post.postId);
              setState(() {});
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: posts.callPosts(),
            builder: (context, AsyncSnapshot asyncSnapshot) {
              if (!asyncSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<DocumentSnapshot> postList = asyncSnapshot.data.docs;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: Text(
                      postList[widget.index]["title"].toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoSlab(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Divider(
                      color: Colors.black87,
                      thickness: 0.5,
                      height: 75,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      postList[widget.index]["subtitle"].toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            "/commentPage",
            arguments: {'postId': widget.postId},
          );
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              AppLocalizations.of(context)!.addComment,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
