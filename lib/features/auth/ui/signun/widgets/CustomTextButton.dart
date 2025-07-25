import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16.0,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding is EdgeInsets
          ? EdgeInsets.only(
              left: (padding as EdgeInsets).left.w,
              right: (padding as EdgeInsets).right.w,
              top: (padding as EdgeInsets).top.h,
              bottom: (padding as EdgeInsets).bottom.h,
            )
          : padding,
      child: SizedBox(
        width: double.infinity,
        height: 50.h,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: fontWeight,
              fontSize: fontSize.sp,
            ),
          ),
        ),
      ),
    );
  }
}
