import 'package:fit_training/models/exercise_entity.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/pages/crud_training/widgets/exercise_dialog.dart';
import 'package:fit_training/stores/training/training_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CrudExerciseTile extends StatefulWidget {
  final ExerciseEntity exercise;
  final int index;
  const CrudExerciseTile(this.exercise, this.index, {Key? key }) : super(key: key);

  @override
  State<CrudExerciseTile> createState() => _CrudExerciseTileState();
}

class _CrudExerciseTileState extends State<CrudExerciseTile> {

  final trainingStore = GetIt.I.get<TrainingStore>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.exercise.name!),
      subtitle: Text(
        "${widget.exercise.serie} x ${widget.exercise.repeat} ${widget.exercise.weight != '' ?  '(${widget.exercise.weight})' : ''}"
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => DialogWidget(
              title: "Atenção",
              subTitle: "Deseja apagar este exercicio?",
              primarylabel: "Confirmar",
              secundaryLabel: "Cancelar",
              primaryFunc: () {
                trainingStore.removeExercise(widget.index);
                Navigator.pop(context);
              },
              secundaryFunc: () => Navigator.pop(context)
            )
          );
        },
      ),
      onTap: () async {
        ExerciseEntity? exercise = await showDialog(
          context: context,
          builder: (context) => ExerciseDialog(exercise: widget.exercise)
        );

        if(exercise != null) {
          trainingStore.editExercise(exercise, widget.index);
        }
      },
    );
  }
}