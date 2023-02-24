import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/styles.dart';

class SearchFiledWidget extends StatelessWidget {
  SearchFiledWidget({super.key, required this.onChanged});

  final Function(String) onChanged;

  final inputDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.only(top: 10.w),
    hintText: 'Search coin pairs',
    hintStyle: GoogleFonts.barlow(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: StyleColors.body2,
    ),
    border: InputBorder.none,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374.w,
      height: 40.w,
      margin: EdgeInsets.fromLTRB(20.w, 14.w, 20.w, 0),
      decoration: BoxDecoration(
        color: StyleColors.searchBox,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(11.w, 9.w, 5.w, 0),
            child: Icon(
              Icons.search,
              color: StyleColors.body2,
              size: 24.w,
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: GoogleFonts.barlow(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: StyleColors.white,
              ),
              cursorColor: StyleColors.white,
              decoration: inputDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
