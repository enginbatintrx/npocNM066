import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class createCSelect extends StatelessWidget {
  String colorName;
  Color colorType;
  VoidCallback voidCallback;
  createCSelect({
    required this.voidCallback,
    required this.colorName,
    required this.colorType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: voidCallback,
        child: Container(
          decoration: BoxDecoration(color: colorType),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              colorName,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
