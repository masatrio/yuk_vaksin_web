import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/core/base_color.dart';

class PrimaryButton extends StatelessWidget {
  final bool isLoading;
  final Color? primaryColor;
  final VoidCallback onTap;
  final Widget? icon;
  final String label;

  const PrimaryButton(
      {Key? key,
      this.isLoading = false,
      this.primaryColor = blue,
      required this.onTap,
      required this.label,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isLoading ? null : onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: body()),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              isLoading ? Colors.grey[300] : primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
        ));
  }

  Widget body() {
    if (isLoading) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: Colors.white,
        ),
      );
    } else {
      if (icon != null) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            const SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white),
            ),
          ],
        );
      } else {
        return Text(
          label,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
        );
      }
    }
  }
}
