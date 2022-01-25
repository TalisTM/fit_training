import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'exercise_widget.dart';

class ExerciseTile extends StatefulWidget {
  final DocumentSnapshot data;
  const ExerciseTile(this.data, {Key? key }) : super(key: key);

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: ListTile(
        title: Text(widget.data['name']),
        subtitle: Text(
          "${widget.data["serie"]} x ${widget.data["repeat"]} ${widget.data["weight"] != '' ?  '(${widget.data["weight"]})' : ''}"
        ),
        trailing: Checkbox(
          value: widget.data["check"],
          activeColor: Theme.of(context).primaryColor,
          onChanged: (value) {
            widget.data.reference.update(
              {
                "check": value
              }
            );
          },
        ),
        onTap: () async {
          var retorno = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => ExerciseWidget(widget.data)
          );
          if(retorno != null && retorno) {
            widget.data.reference.update(
              {
                "check": true
              }
            );
          }
        },
      ),
    );
  }
}