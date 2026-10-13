import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apk_analyzer/extensions/context_extensions.dart';
import 'package:apk_analyzer/utils/constants/sizes.dart';

class TextFieldData extends StatefulWidget {
  const TextFieldData({
    super.key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.enabled = true,
    this.isPassword = false,
    this.maxLines = 1,
    this.maxLength,
    this.focusNode,
    this.suffixIcon,
    this.onChanged,
    this.formatters,
  });
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool isPassword;
  final int? maxLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final IconData? suffixIcon;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? formatters;

  @override
  State<TextFieldData> createState() => _TextFieldDataState();
}

class _TextFieldDataState extends State<TextFieldData> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // TextField Semantics
        Expanded(
          child: Semantics(
            container: true, // Forces it to be read separately
            child: TextFormField(
              controller: widget.controller,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              autovalidateMode: AutovalidateMode.onUnfocus,
              inputFormatters: widget.formatters ?? [],
              autofocus: false,
              focusNode: widget.focusNode,
              obscureText: widget.isPassword ? _obscureText : false,
              onChanged: widget.onChanged,
              style: context.textTheme.titleMedium,
              decoration: InputDecoration(
                hintText: widget.hintText,
                suffixIcon: widget.suffixIcon != null
                    ? Icon(
                        widget.suffixIcon,
                        size: AppSizes.md.w,
                      )
                    : null,
                errorMaxLines:
                    10, // Allow error messages to span multiple lines
              ),
            ),
          ),
        ),

        // Password toggle button Semantics
        if (widget.isPassword)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Semantics(
              container: true, // Forces independent reading
              label: _obscureText ? "Show password" : "Hide password",
              button: true,
              child: ExcludeSemantics(
                excluding: true,
                child: TextButton(
                  onPressed: _togglePasswordVisibility,
                  child: Text(
                    _obscureText ? "Show" : "Hide",
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
