import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:npocnm/server/firebase_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post.dart';

class Helper {
  firebasePost post = firebasePost();
  List<Post> allPosts = [];
  List<Post> favoritePosts = [];

  Future<void> fetchAllPosts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('posts').get();

    allPosts = snapshot.docs
        .map((doc) => Post(
              postId: doc.id,
              title: doc['title'],
              subtitle: doc['subtitle'],
              color: doc['color'],
              comments: doc['comments'],
              // Diğer alanlar
            ))
        .toList();
  }

  Future<void> loadFavoritePosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? favoritePostIds = prefs.getStringList('favoritePostIds');

    if (favoritePostIds != null) {
      favoritePostIds =
          favoritePostIds.toSet().toList(); // Tekrar edenleri temizle
      List<Post> favoritePostsList = allPosts.where((post) {
        return favoritePostIds!.contains(post.postId);
      }).toList();

      favoritePosts = favoritePostsList;
    }
  }

  Future<void> addFavoritePost(Post post) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritePostIds = prefs.getStringList('favoritePostIds') ?? [];
    favoritePostIds.add(post.postId!);
    await prefs.setStringList('favoritePostIds', favoritePostIds);

    favoritePosts.add(post);
  }

  Future<void> removeAllFavoritePosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('favoritePostIds'); // favoritePostIds anahtarını siler
    favoritePosts.clear(); // favoritePosts listesini temizler
  }
}
