import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldWidget extends StatelessWidget {

  final String label;
  final String? hintText;
  final TextEditingController controller;
  final List<MaskTextInputFormatter>? formatters;
  final bool obscureText;
  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final String? errorText;
  final Function(String)? onChanged;
  final bool autofocus;

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.controller,
    this.hintText,
    this.formatters,
    this.obscureText = false,
    this.keyboardType,
    this.padding,
    this.errorText,
    this.onChanged,
    this.autofocus = false,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        autofocus: autofocus,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: formatters,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).dividerColor),
          errorText: errorText,
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[400]!)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red)
          ),
          labelStyle: TextStyle(
            color: Theme.of(context).cardColor
          )
        )
      ),
    );
  }
}