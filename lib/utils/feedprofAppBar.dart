import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_Button.dart';

AppBar feedAppBar(BuildContext context, Widget button) {
  return AppBar(
    elevation: 0,
    title: Text(
      "NpocNM",
      style:
          GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    actions: [button],
    automaticallyImplyLeading: false,
  );
}
