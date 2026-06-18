import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget{
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool? obscureText;
  final VoidCallback? onSuffixIconPressed;
  final TextInputType keyboardType;
  

  const CommonTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.validator,
    this.isPassword = false,
    this.obscureText,
    this.onSuffixIconPressed,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      style: TextStyle(color: theme.colorScheme.onSurface),
      cursorColor: primaryColor,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6)),
        prefixIcon: Icon(prefixIcon, color: primaryColor, size: 22),
        suffixIcon: isPassword 
          ? IconButton(
            onPressed: onSuffixIconPressed, 
            icon: Icon(
              (obscureText ?? true) ? Icons.visibility_off : Icons.visibility,
              color: primaryColor.withOpacity(0.7),
              size: 22,
            ))
          : null,
        filled: true,
        fillColor: primaryColor.withOpacity(0.09),

        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }
}