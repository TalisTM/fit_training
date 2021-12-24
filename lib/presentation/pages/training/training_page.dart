import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/presentation/components/widgets/appbar_widget.dart';
import 'package:fit_training/presentation/pages/training/widgets/exercise_tile.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TrainingPage extends StatefulWidget {
  final DocumentSnapshot data;
  const TrainingPage(this.data, {Key? key}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {

  final userStore = GetIt.I.get<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(label: widget.data["name"]),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).collection("training").doc(widget.data.id).collection("exercises").snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator()
              );
            default:
              List<DocumentSnapshot>? docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return ExerciseTile(docs[index]);
                }
              );
              //return ExerciseTile();
          }
        }
      )
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //   child: ButtonWidget(
      //     label: "Finalizar",
      //     onPressed: () {
      //       bool notCheck = false;
      //       trainingStore.treino['series'][widget.indexSerie]['exercise'].forEach((exercise) {
      //         if(!exercise['check']) {
      //           notCheck = true;
      //         }
      //       });
            
      //       if(notCheck) {
      //         showDialog(
      //           context: context,
      //           builder: (context) => DialogWidget(
      //             title: "Tem certeza?",
      //             subTitle: "Ainda há exercícios para concluir.",
      //             primarylabel: "Sim",
      //             secundaryLabel: "Cancelar",
      //             primaryFunc: () {
      //               Map aux = trainingStore.treino;
      //               aux['quantity']++;

      //               aux['series'][widget.indexSerie]['exercise'].forEach((exercise) {
      //                 exercise['done'] = 0;
      //                 exercise['check'] = false;
      //               });

      //               trainingStore.setTraining(aux);
      //               Database.setDados();

      //               Navigator.pop(context);
      //               Navigator.pop(context);
      //             },
      //             secundaryFunc: () => Navigator.pop(context)
      //           )
      //         );
      //       } else {
      //         showDialog(
      //           context: context,
      //           builder: (context) => DialogWidget(
      //             title: "Finalizar treino",
      //             subTitle: "Tem certeza que deseja finalizar este treino?",
      //             primarylabel: "Sim",
      //             secundaryLabel: "Cancelar",
      //             primaryFunc: () {
      //               Map aux = trainingStore.treino;
      //               aux['quantity']++;

      //               aux['series'][widget.indexSerie]['exercise'].forEach((exercise) {
      //                 exercise['done'] = 0;
      //                 exercise['check'] = false;
      //               });

      //               trainingStore.setTraining(aux);
      //               Database.setDados();

      //               Navigator.pop(context);
      //               Navigator.pop(context);
      //             },
      //             secundaryFunc: () => Navigator.pop(context)
      //           )
      //         );
      //       }
      //     }
      //   ),
      // )
    );
  }
}