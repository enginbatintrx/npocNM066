import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../server/firebase_post.dart';
import '../../utils/commentBuilder.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({Key? key}) : super(key: key);
  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  TextEditingController comment = TextEditingController();
  firebasePost posts = firebasePost();
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final postId = arguments['postId'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.comments,
          style:
              GoogleFonts.robotoSlab(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: posts.callComments(postId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('No data available');
                }

                final documentSnapshot =
                    snapshot.data as DocumentSnapshot<Map<String, dynamic>>?;

                if (documentSnapshot == null || !documentSnapshot.exists) {
                  return Text('Document does not exist');
                }

                final commentsList =
                    documentSnapshot.get("comments") as List<dynamic>;

                return ListView.builder(
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    final commentText = commentsList[index] as String;

                    return commentsBuilder(
                      comment: commentText,
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              padding: EdgeInsets.only(left: 15, right: 20),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextField(
                            controller: comment,
                            decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!.textfield,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        print(comment.text);
                        if (comment.text.isNotEmpty) {
                          posts.addComment(postId, comment.text);
                          comment.clear();
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(AppLocalizations.of(context)!.err),
                                content: Text(
                                  AppLocalizations.of(context)!.pleaseEnter,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.okay),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.grey.shade900,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
