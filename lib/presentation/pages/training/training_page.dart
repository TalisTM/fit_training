import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/presentation/components/widgets/appbar_widget.dart';
import 'package:fit_training/presentation/components/widgets/button_widget.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
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
        stream: FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).collection("training").doc(widget.data.id).collection("exercises").orderBy("time").snapshots(),
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ButtonWidget(
          label: "Finalizar",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DialogWidget(
                title: "Finalizar treino",
                subTitle: "Tem certeza que deseja finalizar este treino?",
                primarylabel: "Sim",
                secundaryLabel: "Cancelar",
                primaryFunc: () {
                  FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).update({"qtdTraining": userStore.user.qtdTraining! + 1});

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                secundaryFunc: () => Navigator.pop(context)
              )
            );
          }
        ),
      )
    );
  }
}