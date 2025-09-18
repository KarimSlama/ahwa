import 'package:flutter/material.dart';

class OrderTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLength, maxLines;
  final IconData prefixIcon;
  final String hintText;
  const OrderTextFormField({
    super.key,
    required this.controller,
    this.maxLength,
    this.maxLines,
    required this.prefixIcon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.text,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        alignLabelWithHint: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.black12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Colors.black87.withValues(alpha: .4), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Colors.black87.withValues(alpha: .4), width: 1),
        ),
      ),
    );
  }
}
