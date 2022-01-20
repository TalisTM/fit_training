import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/models/exercise_entity.dart';
import 'package:fit_training/models/training_entity.dart';
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
  final TrainingEntity? training;
  const CrudTraining({this.training, Key? key }) : super(key: key);

  @override
  _CrudTrainingState createState() => _CrudTrainingState();
}

class _CrudTrainingState extends State<CrudTraining> {

  final userStore = GetIt.I.get<UserStore>();
  final trainingStore = GetIt.I.get<TrainingStore>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _abstractController = TextEditingController();
  String? _nameErro;
  String? _abstractErro;

  @override
  void initState() {
    super.initState();

    if(widget.training != null) {
      _nameController.text = widget.training!.name!;
      trainingStore.setTraining(widget.training!);
    }
  }

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
              errorText: _nameErro,
              onChanged: (_) {
                setState(() {
                  _nameErro = null;
                });
              },
              controller: _nameController
            ),
            TextFieldWidget(
              padding: const EdgeInsets.only(top: 15),
              label: "Descrição (opcional)",
              errorText: _abstractErro,
              onChanged: (_) {
                setState(() {
                  _abstractErro = null;
                });
              },
              controller: _abstractController
            ),
            const SizedBox(height: 5),
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
            ),
            const SizedBox(height: 50),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        label: Text("Adicionar treino", style: Theme.of(context).textTheme.headline3),
        icon: const Icon(Icons.add, size: 28),
        onPressed: () async {
          if(_nameController.text.trim().isEmpty) {
            _nameErro = "Nome inválido";
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
            trainingStore.setName(_nameController.text.trim());
            if(_abstractController.text.trim().isNotEmpty) trainingStore.setAbstract(_abstractController.text.trim());

            try {
              String? id;
              await FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).collection("training").add(
                {
                  "name": trainingStore.training.name,
                  "abstract": "testee",
                  "time": Timestamp.now()
                }
              ).then((value) {
                id = value.id;
              });
              
              for (var e in trainingStore.training.exercises!) {
                Map<String, dynamic> exercise = e.toMap();
                exercise['time'] = Timestamp.now();
                FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).collection("training").doc(id).collection("exercises").add(exercise);
              }
            } catch (e) {
              null;
            }
            
            trainingStore.clear();
            Navigator.pop(context);
          }
        }
      ),
    );
  }
}