import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final Widget? icon;
  final TextEditingController? controller;
  final Color? color;
  final Color? prefixIconColor;
  final TextStyle? fieldTextStyle;
  final TextInputType? textInputType;
  final Function(String?)? onChanged;
  final bool? obscureText; // Add this to make obscureText optional

  const AppTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
    this.prefixIconColor,
    this.fieldTextStyle,
    this.textInputType,
    this.color,
    this.onChanged,
    this.obscureText, // Accept the obscureText flag
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscurePassword; // Initialize the obscurePassword flag dynamically

  @override
  void initState() {
    super.initState();
    obscurePassword = widget.obscureText ??
        false; // Set default to false if obscureText is null
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: widget.color ?? Colors.white),
      ),
      child: TextField(
        // textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        style:
            widget.fieldTextStyle ?? GoogleFonts.vazirmatn(color: Colors.white),
        keyboardType: widget.textInputType ?? TextInputType.text,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText == true
            ? obscurePassword // Use the flag for obscuring text
            : false, // If not obscured, always show plain text
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          prefixIconColor: widget.prefixIconColor ?? Colors.white,
          hintText: widget.hintText,

          border: InputBorder.none,
          // Show the visibility toggle icon only when obscureText is true
          suffixIcon: widget.obscureText == true
              ? IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                )
              : null, // No suffix icon if not obscured
          hintStyle: GoogleFonts.vazirmatn(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}
