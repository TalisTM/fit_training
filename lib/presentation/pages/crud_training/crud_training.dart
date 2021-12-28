import 'package:fit_training/models/training_entity.dart';
import 'package:fit_training/presentation/components/widgets/appbar_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_button_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_field_widget.dart';
import 'package:fit_training/presentation/pages/crud_training/widgets/exercise_dialog.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'widgets/crud_exercise_tile.dart';

class CrudTraining extends StatefulWidget {
  const CrudTraining({ Key? key }) : super(key: key);

  @override
  _CrudTrainingState createState() => _CrudTrainingState();
}

class _CrudTrainingState extends State<CrudTraining> {

  final userStore = GetIt.I.get<UserStore>();
  final newTraining = TrainingEntity();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(label: "Adicionar Treino"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextFieldWidget(
              label: "Nome do treino",
              controller: _controller
            ),
            if (newTraining.exercises != null)
              ListView.builder(
                itemCount: newTraining.exercises?.length,
                itemBuilder: (context, index){
                  return CrudExerciseTile(newTraining.exercises![index]);
                },
              ),
            TextButtonWidget(
              label: "Adicionar Exercicio",
              icon: Icons.add,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const ExerciseDialog()
                );
              }
            )
          ],
        )
      )
    );
  }
}