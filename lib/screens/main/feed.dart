import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:npocnm/server/firebase_post.dart';
import 'package:npocnm/utils/create_Button.dart';
import 'package:npocnm/utils/feedprofAppBar.dart';

import '../../utils/postCard.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  firebasePost posts = firebasePost();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: feedAppBar(
        context,
        Post_Create_Button(
          voidCallback: () {
            Navigator.pushNamed(context, '/createPost');
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: posts.callPosts(),
        builder: (context, AsyncSnapshot asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> postList = asyncSnapshot.data.docs;
          return ListView.builder(
            itemCount: postList.length,
            itemBuilder: (context, index) {
              var commentsData = postList[index]["comments"];
              var commentCount = commentsData is List ? commentsData.length : 0;
              return PostCard(
                subtitle: postList[index]["subtitle"],
                postId: postList[index]["postId"],
                commentnumber: commentCount,
                color: postList[index]["color"],
                title: postList[index]["title"],
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
