import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialLoginSection extends StatelessWidget {
  final String facebookLabel;
  final String googleLabel;
  final VoidCallback onFacebookTap;
  final VoidCallback onGoogleTap;

  final String questionText;
  final String actionText;
  final VoidCallback onActionTap;

  const SocialLoginSection({
    super.key,
    required this.facebookLabel,
    required this.googleLabel,
    required this.onFacebookTap,
    required this.onGoogleTap,
    required this.questionText,
    required this.actionText,
    required this.onActionTap,
    required Null Function() onSignUpTap,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "or continue with",
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 16.h),

        // Facebook & Google Buttons
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: TextButton.icon(
                  onPressed: onFacebookTap,
                  icon: Image.asset(
                    'assets/Facebookicon.png',
                    height: 20.h,
                    width: 20.w,
                  ),
                  label: Text(
                    facebookLabel,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: TextButton.icon(
                  onPressed: onGoogleTap,
                  icon: Image.asset(
                    'assets/Googelicone.png',
                    height: 20.h,
                    width: 20.w,
                  ),
                  label: Text(
                    googleLabel,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        12.verticalSpace,

        // Bottom Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questionText,
              style: TextStyle(fontSize: 14.sp),
            ),
            TextButton(
              onPressed: onActionTap,
              child: Text(
                actionText,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
