import 'dart:io';

import 'package:fit_training/database/database.dart';
import 'package:fit_training/models/training_entity.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/pages/training/training_page.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TrainingTile extends StatefulWidget {
  final TrainingEntity training;

  const TrainingTile(
    this.training,
    {
    Key? key
    }) : super(key: key);

  @override
  State<TrainingTile> createState() => _TrainingTileState();
}

class _TrainingTileState extends State<TrainingTile> {

  final userStore = GetIt.I.get<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(widget.training.name!),
        subtitle: Text(widget.training.abstract ?? ""),
        trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor),
        onTap: () async {
          bool hasTraining = false;
          for(var exercise in widget.training.exercises!) {
            if(exercise.check! || exercise.done != 0) {
              hasTraining = true;
            }
          }
      
          if(hasTraining) {
            await showDialog(
              context: context,
              builder: (context) => DialogWidget(
                title: "Treino em progresso",
                subTitle: "Deseja continuar ou iniciar um novo treino?",
                primarylabel: "Continuar",
                secundaryLabel: "Novo",
                primaryFunc: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingPage(widget.training)));
                },
                secundaryFunc: () {
                  for(var exercise in widget.training.exercises!) {
                    exercise.done = 0;
                    exercise.check = false;
                  }
      
                  Database.saveTraining();
      
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingPage(widget.training)));
                },
              )
            );
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingPage(widget.training)));
          }
        } 
      ),
    );
  }
}