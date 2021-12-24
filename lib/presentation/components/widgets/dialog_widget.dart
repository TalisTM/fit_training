import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {

  final String title;
  final String subTitle;
  final String primarylabel;
  final String secundaryLabel;
  final VoidCallback primaryFunc;
  final VoidCallback secundaryFunc;

  const DialogWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.primarylabel,
    required this.secundaryLabel,
    required this.primaryFunc,
    required this.secundaryFunc
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title, style: Theme.of(context).textTheme.headline6),
        content: Text(subTitle, style: Theme.of(context).textTheme.subtitle1),
        actions: [
          TextButton(
            child: Text(secundaryLabel, style: Theme.of(context).textTheme.subtitle2),
            onPressed: secundaryFunc
          ),
          TextButton(
            child: Text(primarylabel, style: Theme.of(context).textTheme.subtitle2),
            onPressed: primaryFunc
          )
        ],
      ),
    );
            
  }
}