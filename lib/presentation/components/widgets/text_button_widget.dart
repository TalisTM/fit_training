import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {

  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  const TextButtonWidget({
    Key? key,
    required this.label,
    this.icon,
    required this.onPressed
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              Icons.add,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          if(icon != null)
            const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22
            ),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}