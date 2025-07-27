import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable custom text field widget with optional icons, password toggle,
/// and field label with an asterisk for required fields.
class CustomTextField extends StatefulWidget {
  final String hintText; // Placeholder inside the text field
  final String fieldName; // Label above the text field
  final bool isPassword; // Whether this is a password field (hides input)
  final TextEditingController? controller; // External controller, if provided
  final IconData? prefixicone; // Optional prefix icon
  final IconData? suffixIcon; // Optional suffix icon
  final ValueChanged<String>? onChange; // Callback when text changes

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
  // Internal controller if no external one is passed
  final TextEditingController _controller = TextEditingController();

  // Controls whether the password is obscured
  bool _obscureText = true;

  // Dispose the internal controller if used
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0.w,
      ), // Responsive horizontal padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show the label above the field if provided
          if (widget.fieldName.isNotEmpty)
            RichText(
              text: TextSpan(
                text: widget.fieldName, // Field label
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
                children: const [
                  TextSpan(
                    text: " *", // Red asterisk for required field
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          SizedBox(height: 8.h), // Spacing between label and input field
          // The main text field
          TextFormField(
            onChanged: widget.onChange, // Handle text change
            controller:
                widget.controller ??
                _controller, // Use passed or internal controller
            obscureText: widget.isPassword
                ? _obscureText
                : false, // Toggle password visibility
            style: TextStyle(fontSize: 16.sp), // Input text style

            decoration: InputDecoration(
              // Blue border when focused
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),

              // Red border when there's an error
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                
              ),

              // Placeholder text inside the field
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 14.sp),

              // Default border styling with rounded corners
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),

              // Internal padding for better spacing
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),

              // Optional prefix icon (like an email or phone icon)
              prefixIcon: widget.prefixicone != null
                  ? Icon(widget.prefixicone, size: 22.sp)
                  : null,

              // Suffix: password eye toggle or a static icon
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 22.sp,
                      ),
                      onPressed: () {
                        // Toggle visibility on tap
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
