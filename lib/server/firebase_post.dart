import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:npocnm/models/comment.dart';

import '../models/post.dart';

class firebasePost {
  var firestore = FirebaseFirestore.instance;
  callPosts() {
    CollectionReference posts = firestore.collection("posts");
    return posts.snapshots();
  }

  callComments(String postId) {
    return firestore
        .collection("posts")
        .doc(
          postId,
        )
        .snapshots();
  }

  void createPost(Post post) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid;

    if (userId != null) {
      final postRef = FirebaseFirestore.instance.collection('posts').doc();

      await postRef.set({
        'userId': userId,
        'title': post.title,
        'subtitle': post.subtitle,
        'postId': postRef.id,
        'comments': post.comments,
        'color': post.color
        // Diğer post verileri
      });

      print('Post created successfully');
    }
  }

  void addComment(String postId, String comment) async {
    try {
      final postRef =
          FirebaseFirestore.instance.collection('posts').doc(postId);

      final postDoc = await postRef.get();
      final commentsList = postDoc.data()?['comments'] ?? [];

      commentsList.add(comment);

      await postRef.update({
        'comments': commentsList,
      });
    } catch (e) {
      print('An error occurs while adding a comment: $e');
    }
  }
}
