import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final String label;
  final Color activeColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final ValueChanged<bool>? onChanged;

  const CustomCheckbox({
    super.key,
    required this.label,
    this.activeColor = Colors.blue,
    this.fontSize = 14.0,
    this.padding = const EdgeInsets.only(top: 0),
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
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ✅ Checkbox + label
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: _handleChange,
                activeColor: widget.activeColor,
              ),
              Text(widget.label, style: TextStyle(fontSize: widget.fontSize)),
            ],
          ),

          // ✅ Forgot password button
          TextButton(
            onPressed: () {
              // Handle forgot password tap
            },
            child: const Text(
              "Forgot the password?",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
