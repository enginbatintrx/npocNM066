import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:npocnm/server/firebase_post.dart';
import 'package:npocnm/utils/colorToTitle.dart';
import 'package:npocnm/utils/create_Button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/post.dart';

import '../utils/createColorSelect.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  firebasePost posts = firebasePost();
  bool whicbuttontick = false;
  int colorIndex = 4;
  Color whichColor = Colors.white;
  List<Color> colors = [
    Colors.purple.shade100,
    Colors.green.shade100,
    Colors.lightBlue.shade100,
    Colors.yellow.shade100,
    Colors.white
  ];
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();

  void createPosting() {
    final color = whichColor.value;
    final ptitle = title.text;
    final psubtitle = subtitle.text;
    if (title != null && subtitle != null) {
      if (ptitle.length >= 3 && psubtitle.length >= 3) {
        final postData = Post(
          color: color,
          title: ptitle,
          subtitle: psubtitle,
          comments: [],
        );

        posts.createPost(postData);
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.err),
              content: Text(AppLocalizations.of(context)!.pleaseEnter),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.okay),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appbar_create_button(
                  () {
                    setState(() {
                      whicbuttontick = false;
                    });
                  },
                  whicbuttontick == true ? Colors.black : Colors.white,
                  AppLocalizations.of(context)!.create,
                ),
                appbar_create_button(
                  () {
                    setState(() {
                      whicbuttontick = true;
                    });
                  },
                  whicbuttontick == false ? Colors.black : Colors.white,
                  AppLocalizations.of(context)!.review,
                ),
              ],
            ),
          ),
        ),
        actions: [
          Post_Create_Button(
            voidCallback: createPosting,
          ),
        ],
      ),
      body: whicbuttontick == false
          ? create(
              context,
            )
          : preview(),
    );
  }

  SafeArea create(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: colorIndex != 4
                  ? Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: whichColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Text(
                              whichColor.colorName(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900),
                            ),
                            GestureDetector(
                              child: Icon(Icons.close),
                              onTap: () {
                                colorIndex = 4;
                                setState(() {
                                  whichColor = Colors.white;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        createCSelect(
                          voidCallback: () {
                            colorIndex = 0;
                            whichColor = colors[colorIndex];

                            setState(() {});
                          },
                          colorName: "Purple",
                          colorType: Colors.purple.shade100,
                        ),
                        createCSelect(
                          voidCallback: () {
                            colorIndex = 1;
                            whichColor = colors[colorIndex];
                            setState(() {});
                          },
                          colorName: "Green",
                          colorType: Colors.green.shade100,
                        ),
                        createCSelect(
                          voidCallback: () {
                            colorIndex = 2;
                            whichColor = colors[colorIndex];

                            setState(() {});
                          },
                          colorName: "Blue",
                          colorType: Colors.lightBlue.shade100,
                        ),
                        createCSelect(
                          voidCallback: () {
                            colorIndex = 3;
                            whichColor = colors[colorIndex];

                            setState(() {});
                          },
                          colorName: "Yellow",
                          colorType: Colors.yellow.shade100,
                        ),
                        createCSelect(
                          voidCallback: () {
                            colorIndex = 4;
                            whichColor = colors[colorIndex];

                            setState(() {});
                          },
                          colorName: "Default",
                          colorType: Colors.white,
                        ),
                      ],
                    ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.label,
                    border: InputBorder.none,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider(
                    color: Colors.black87,
                    height: 45,
                  ),
                ),
                TextFormField(
                  controller: subtitle,
                  minLines: 1,
                  maxLines: 15,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.yourpost,
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SafeArea preview() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Column(
                children: [
                  Text(
                    title.text,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(
                      color: Colors.black87,
                      height: 45,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      subtitle.text,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
