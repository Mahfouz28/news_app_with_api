import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInHeader extends StatelessWidget {
  final String title;
  final String title1;
  final Color color;
  final Color color1;
  final String suptitel;

  const SignInHeader({
    super.key,
    required this.title,
    required this.color,
    required this.color1,
    required this.title1,
    required this.suptitel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            children: [
              TextSpan(
                text: title1,
                style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: color1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          suptitel,
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
