import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final String label;
  final VoidCallback onPressed;
  const ButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        label,
        style: Theme.of(context).textTheme.button,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
        minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(55)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
      ),
      onPressed: onPressed,
    );
  }
}