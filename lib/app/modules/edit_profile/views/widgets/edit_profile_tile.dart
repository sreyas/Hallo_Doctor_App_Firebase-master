import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileTile extends StatelessWidget {
  const EditProfileTile({Key? key, this.title, this.subtitle, this.onTap})
      : super(key: key);

  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ?? '',
                      style: GoogleFonts.inter(
                          fontSize: 13, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    subtitle ?? '',
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.w400),
                    maxLines: 2,
                  )
                ],
              ),
            ),
            onTap == null
                ? SizedBox.shrink()
                : TextButton(
                    onPressed: onTap,
                    child: Text(
                      'Change',
                      style: GoogleFonts.inter(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ))
          ],
        ),
      ),
    );
  }
}
