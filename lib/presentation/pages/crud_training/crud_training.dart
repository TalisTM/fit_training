import 'package:fit_training/models/exercise_entity.dart';
import 'package:fit_training/presentation/components/widgets/appbar_widget.dart';
import 'package:fit_training/presentation/components/widgets/button_widget.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_button_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_field_widget.dart';
import 'package:fit_training/presentation/pages/crud_training/widgets/exercise_dialog.dart';
import 'package:fit_training/stores/training/training_store.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'widgets/crud_exercise_tile.dart';

class CrudTraining extends StatefulWidget {
  const CrudTraining({ Key? key }) : super(key: key);

  @override
  _CrudTrainingState createState() => _CrudTrainingState();
}

class _CrudTrainingState extends State<CrudTraining> {

  final userStore = GetIt.I.get<UserStore>();
  final trainingStore = GetIt.I.get<TrainingStore>();

  final TextEditingController _controller = TextEditingController();
  String? _erro;

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
              errorText: _erro,
              onChanged: (_) {
                setState(() {
                  _erro = null;
                });
              },
              controller: _controller
            ),
            if (trainingStore.training.exercises != null)
              Observer(
                builder: (context) {
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: trainingStore.training.exercises?.length,
                    itemBuilder: (context, index){
                      return CrudExerciseTile(trainingStore.training.exercises![index], index);
                    },
                  );
                }
              ),
            TextButtonWidget(
              label: "Adicionar Exercicio",
              icon: Icons.add,
              onPressed: () async {
                ExerciseEntity? exercise;

                exercise = await showDialog(
                  context: context,
                  builder: (context) => const ExerciseDialog()
                );

                if(exercise != null) {
                  trainingStore.addExercise(exercise);
                }
              }
            )
          ],
        )
      ),
      floatingActionButton: ButtonWidget(
        label: "Adicionar Treino",
        onPressed: () {
          if(_controller.text.trim().isEmpty) {
            _erro = "Nome inválido";
            setState(() {});
          } else if(trainingStore.training.exercises!.isEmpty) {
            showDialog(
              context: context,
              builder: (context) => DialogWidget(
                title: "Atenção",
                subTitle: "Adicione pelo menos um exercício primeiro",
                primarylabel: "Ok",
                primaryFunc: () => Navigator.pop(context),
                secundaryLabel: "",
                secundaryFunc: () {
                  
                }
              )
            );
          } else {
            trainingStore.setName(_controller.text.trim());

            //adicionar o treino completo no firebaseeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
          }
        }
      )
    );
  }
}