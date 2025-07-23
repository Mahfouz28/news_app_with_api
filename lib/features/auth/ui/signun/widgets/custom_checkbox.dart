import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckbox extends StatefulWidget {
  final String label;
  final Color activeColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<bool>? onChanged;

  const CustomCheckbox({
    super.key,
    required this.label,
    this.activeColor = Colors.blue,
    this.fontSize,
    this.padding,
    this.onChanged,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  void _handleChange(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Checkbox and label
          Row(
            children: [
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: Checkbox(
                  value: isChecked,
                  onChanged: _handleChange,
                  activeColor: widget.activeColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                widget.label,
                style: TextStyle(fontSize: widget.fontSize ?? 14.sp),
              ),
            ],
          ),

          // Forgot password
          TextButton(
            onPressed: () {
              // Handle forgot password tap
            },
            child: Text(
              "Forgot the password?",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.blue,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
