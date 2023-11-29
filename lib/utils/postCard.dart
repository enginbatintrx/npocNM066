import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:npocnm/screens/post/postDetail.dart';

import '../models/post.dart';

class PostCard extends StatelessWidget {
  int index;
  String title;
  int color;
  int commentnumber;
  String postId;
  String subtitle;

  PostCard({
    required this.subtitle,
    required this.postId,
    required this.commentnumber,
    required this.color,
    required this.index,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Post post = Post(
      title: title,
      subtitle: subtitle,
      color: color,
      postId: postId,
    );
    return GestureDetector(
      onTap: () {
        print("post");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetail(
              post: post,
              index: index,
              postId: postId,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(color),
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: GoogleFonts.roboto(
                        color: Colors.grey.shade900,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/commentPage',
                      arguments: {'postId': postId},
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.forum,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          commentnumber.toString(),
                          style: GoogleFonts.roboto(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
