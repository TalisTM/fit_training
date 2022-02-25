import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/database/database.dart';
import 'package:fit_training/models/training_entity.dart';
import 'package:fit_training/presentation/components/widgets/appbar_widget.dart';
import 'package:fit_training/presentation/components/widgets/button_widget.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/pages/training/widgets/exercise_tile.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TrainingPage extends StatefulWidget {
  final TrainingEntity training;
  const TrainingPage(this.training, {Key? key}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {

  final userStore = GetIt.I.get<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(label: widget.training.name!),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.training.exercises!.length,
        itemBuilder: (context, index) {
          return ExerciseTile(widget.training.exercises![index]);
        }
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ButtonWidget(
          label: "Finalizar",
          onPressed: () {
            bool notCheck = false;
            for (var exercise in widget.training.exercises!) {
              if(!exercise.check!) {
                notCheck = true;
              }
            }
            
            if(notCheck) {
              showDialog(
                context: context,
                builder: (context) => DialogWidget(
                  title: "Tem certeza?",
                  subTitle: "Ainda há exercícios para concluir.",
                  primarylabel: "Sim",
                  secundaryLabel: "Cancelar",
                  primaryFunc: finalizarTreino,
                  secundaryFunc: () => Navigator.pop(context)
                )
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => DialogWidget(
                  title: "Finalizar treino",
                  subTitle: "Tem certeza que deseja finalizar este treino?",
                  primarylabel: "Sim",
                  secundaryLabel: "Cancelar",
                  primaryFunc: finalizarTreino,
                  secundaryFunc: () => Navigator.pop(context)
                )
              );
            }
          }
        ),
      )
    );
  }

  void finalizarTreino() async {
    userStore.addDone();
    await FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).update({"done": userStore.user.done});
     
    for (var exercise in widget.training.exercises!) {
      exercise.done = 0;
      exercise.check = false;
    }

    Database.saveTraining();

    Navigator.pop(context);
    Navigator.pop(context);
  }
}