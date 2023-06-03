import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle headingText = TextStyle(
    color: Colors.black, fontSize: 30.sp, fontWeight: FontWeight.w600);

TextStyle descriptionText = TextStyle(color: Colors.grey, fontSize: 14.sp);
TextStyle normalText = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold);

SizedBox spaceBetween = SizedBox(height: 8.h);

switchScreenPush(context, screen) {
  return Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (
            context,
            _,
            __,
          ) =>
              screen,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero));
}

switchScreenReplacement(context, screen) {
  return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (context, _, __) => screen,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero));
}
