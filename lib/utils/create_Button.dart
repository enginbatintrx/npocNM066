import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Post_Create_Button extends StatelessWidget {
  VoidCallback voidCallback;
  Post_Create_Button({
    required this.voidCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Text(
            AppLocalizations.of(context)!.create,
            style: GoogleFonts.roboto(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

Expanded appbar_create_button(
    VoidCallback voidCallback, Color color, String buttonName) {
  return Expanded(
    child: GestureDetector(
      onTap: voidCallback,
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            buttonName,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ),
  );
}
