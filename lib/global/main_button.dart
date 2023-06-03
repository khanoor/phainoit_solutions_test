import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool loading;

  MainButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 114, 143),
            borderRadius: BorderRadius.circular(30.r),
          ),
          alignment: Alignment.center,
          height: 50.h,
          width: 250.w,
          child: loading
              ? CircularProgressIndicator()
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )),
    );
  }
}
