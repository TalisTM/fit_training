import 'package:fit_training/models/exercise_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CrudExerciseTile extends StatefulWidget {
  final ExerciseEntity exercise;
  const CrudExerciseTile(this.exercise, {Key? key }) : super(key: key);

  @override
  State<CrudExerciseTile> createState() => _CrudExerciseTileState();
}

class _CrudExerciseTileState extends State<CrudExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.exercise.name!),
      subtitle: Text(
        "${widget.exercise.serie} x ${widget.exercise.repeat} ${widget.exercise.weight != '' ?  '(${widget.exercise.weight})' : ''}"
      ),
      trailing: Observer(
        builder: (context) {
          return Checkbox(
            value: widget.exercise.check,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              
            },
          );
        }
      ),
      onTap: () async {
        // var retorno = await showDialog(
        //   context: context,
        //   barrierDismissible: false,
        //   builder: (context) => ExerciseWidget(
        //     indexSerie: widget.indexSerie,
        //     indexExercise: widget.indexExercise,
        //   )
        // );
        // if(retorno != null && retorno) {
        //   trainingStore.treino['series'][widget.indexSerie]['exercise'][widget.indexExercise]['check'] = true;
        // }
      },
    );
  }
}