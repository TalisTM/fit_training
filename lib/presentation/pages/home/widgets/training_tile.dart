import 'package:flutter/material.dart';

class TrainingTile extends StatelessWidget {
  final int indexSerie;
  const TrainingTile({
    required this.indexSerie,
    Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return ListTile(
    //   title: Text(trainingStore.treino['series'][indexSerie]['name']),
    //   subtitle: Text(trainingStore.treino['series'][indexSerie]['abstractSeries']),
    //   trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor),
    //   onTap: () async {
    //     bool hasTraining = false;
    //     trainingStore.treino['series'][indexSerie]['exercise'].forEach((exercise) {
    //       if(exercise['check'] || exercise['done'] != 0) {
    //         hasTraining = true;
    //       }
    //     });

    //     if(hasTraining) {
    //       await showDialog(
    //         context: context,
    //         builder: (context) => DialogWidget(
    //           title: "Treino em progresso",
    //           subTitle: "Deseja continuar ou iniciar um novo treino?",
    //           primarylabel: "Continuar",
    //           secundaryLabel: "Novo",
    //           primaryFunc: () {
    //             Navigator.pop(context);
    //             Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesPage(indexSerie: indexSerie)));
    //           },
    //           secundaryFunc: () {
    //             Map aux = trainingStore.treino;
    //             aux['series'][indexSerie]['exercise'].forEach((exercise) {
    //               exercise['done'] = 0;
    //               exercise['check'] = false;
    //             });

    //             trainingStore.setTraining(aux);
    //             Database.setDados();

    //             Navigator.pop(context);
    //             Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesPage(indexSerie: indexSerie)));
    //           },
    //         )
    //       );
    //     } else {
    //       Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesPage(indexSerie: indexSerie)));
    //     }
    //   } 
    // );
  }
}