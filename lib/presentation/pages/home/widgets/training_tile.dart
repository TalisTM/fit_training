import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/presentation/pages/training/training_page.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TrainingTile extends StatefulWidget {
  final DocumentSnapshot data;

  const TrainingTile(
    this.data,
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
    return ListTile(
      title: Text(widget.data['name']),
      subtitle: Text(widget.data['abstract']),
      trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor),
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingPage(widget.data)));
        // bool hasTraining = false;
        // trainingStore.treino['series'][indexSerie]['exercise'].forEach((exercise) {
        //   if(exercise['check'] || exercise['done'] != 0) {
        //     hasTraining = true;
        //   }
        // });

        // if(hasTraining) {
        //   await showDialog(
        //     context: context,
        //     builder: (context) => DialogWidget(
        //       title: "Treino em progresso",
        //       subTitle: "Deseja continuar ou iniciar um novo treino?",
        //       primarylabel: "Continuar",
        //       secundaryLabel: "Novo",
        //       primaryFunc: () {
        //         Navigator.pop(context);
        //         Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesPage(indexSerie: indexSerie)));
        //       },
        //       secundaryFunc: () {
        //         Map aux = trainingStore.treino;
        //         aux['series'][indexSerie]['exercise'].forEach((exercise) {
        //           exercise['done'] = 0;
        //           exercise['check'] = false;
        //         });

        //         trainingStore.setTraining(aux);
        //         Database.setDados();

        //         Navigator.pop(context);
        //         Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesPage(indexSerie: indexSerie)));
        //       },
        //     )
        //   );
        // } else {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesPage(indexSerie: indexSerie)));
        // }
      } 
    );
  }
}