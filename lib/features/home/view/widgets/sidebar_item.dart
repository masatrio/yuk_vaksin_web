import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/core/base_color.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  final _isHover = false.obs;

  SidebarItem(
      {Key? key,
      required this.isSelected,
      required this.onTap,
      required this.icon,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => _isHover.value = true,
        onExit: (_) => _isHover.value = false,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                color: _isHover.value || isSelected ? blue : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: _isHover.value || isSelected
                        ? Colors.white
                        : Colors.black,
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                        color: _isHover.value || isSelected
                            ? Colors.white
                            : Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
