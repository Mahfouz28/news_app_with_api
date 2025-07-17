import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String fieldName;
  final bool isPassword;
  final TextEditingController? controller;
  final IconData? prefixicone;
  final ValueChanged<String>? onChange;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.fieldName,
    this.isPassword = false,
    this.controller,
    this.prefixicone,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.fieldName.isNotEmpty)
          RichText(
            text: TextSpan(
              text: widget.fieldName,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              children: const [
                TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: widget.onChange,
          controller: widget.controller ?? _controller,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            prefixIcon: widget.prefixicone != null
                ? Icon(widget.prefixicone)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
