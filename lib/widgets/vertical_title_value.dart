import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/core/base_color.dart';

class VerticalTitleValue extends StatelessWidget {
  final String title;
  final Widget value;

  const VerticalTitleValue({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 14, color: blackGrey),
        ),
        const SizedBox(
          height: 8,
        ),
        value
      ],
    );
  }
}
