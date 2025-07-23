import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String fieldName;
  final bool isPassword;
  final TextEditingController? controller;
  final IconData? prefixicone;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChange;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.fieldName,
    this.isPassword = false,
    this.controller,
    this.prefixicone,
    this.suffixIcon,
    this.onChange,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.fieldName.isNotEmpty)
            RichText(
              text: TextSpan(
                text: widget.fieldName,
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
                children: const [
                  TextSpan(
                    text: " *",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          SizedBox(height: 8.h),
          TextFormField(
            onChanged: widget.onChange,
            controller: widget.controller ?? _controller,
            obscureText: widget.isPassword ? _obscureText : false,
            style: TextStyle(fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 14.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              prefixIcon: widget.prefixicone != null
                  ? Icon(widget.prefixicone, size: 22.sp)
                  : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 22.sp,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.suffixIcon != null
                  ? Icon(widget.suffixIcon, size: 22.sp)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
