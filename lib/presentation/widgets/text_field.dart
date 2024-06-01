import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegularTextInput extends StatelessWidget {
  const RegularTextInput({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.enabled = true,
    this.inputFormatters,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.required = false,
    this.onChanged,
    this.suffix,
    this.keyboardType,
    this.obscureText = false,
  });

  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final IconData? prefixIcon;
  final bool required;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          enabled: enabled,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            labelText: labelText,
            hintText: hintText,
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
