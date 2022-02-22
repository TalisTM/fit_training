import 'package:fit_training/database/database.dart';
import 'package:fit_training/models/exercise_entity.dart';
import 'package:flutter/material.dart';

import 'exercise_widget.dart';

class ExerciseTile extends StatefulWidget {
  final ExerciseEntity exercise;
  const ExerciseTile(this.exercise, {Key? key}) : super(key: key);

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: ListTile(
        title: Text(widget.exercise.name!),
        subtitle: Text(
          "${widget.exercise.serie} x ${widget.exercise.repeat} ${widget.exercise.weight != '' ?  '(${widget.exercise.weight})' : ''}"
        ),
        trailing: Checkbox(
          value: widget.exercise.check,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (value) {
            widget.exercise.check = value;
            setState(() {});
            Database.saveTraining();
          },
        ),
        onTap: () async {
          var retorno = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => ExerciseWidget(widget.exercise)
          );
          if(retorno != null && retorno) {
            widget.exercise.check = true;
            setState(() {});
            Database.saveTraining();
          }
        },
      ),
    );
  }
}