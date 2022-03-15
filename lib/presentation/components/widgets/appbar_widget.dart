import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  final String label;
  final VoidCallback? onPressedBackButton;
  const AppBarWidget({ Key? key, this.label = "", this.onPressedBackButton}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(label),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onPressedBackButton ?? () => Navigator.pop(context),
      )
    );
  }
}