import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class commentsBuilder extends StatelessWidget {
  String comment;

  commentsBuilder({
    required this.comment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  comment,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      leading: Transform.rotate(
        angle: 180 * 3.14 / 180,
        child: IconButton(
          icon: Icon(
            Icons.reply,
            color: Colors.blueGrey.shade700,
            size: 35,
          ),
          onPressed: null,
        ),
      ),
    );
  }
}
