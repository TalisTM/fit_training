import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/models/exercise_entity.dart';
import 'package:fit_training/models/training_entity.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/pages/crud_training/crud_training.dart';
import 'package:fit_training/stores/training/training_store.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditTrainingTile extends StatefulWidget {
  final TrainingEntity training;
  final String id;
  const EditTrainingTile(
    this.training,
    this.id,
    {
    Key? key
    }) : super(key: key);

  @override
  State<EditTrainingTile> createState() => _EditTrainingTileState();
}

class _EditTrainingTileState extends State<EditTrainingTile> {

  final userStore = GetIt.I.get<UserStore>();
  final trainingStore = GetIt.I.get<TrainingStore>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(widget.training.name ?? ""),
        subtitle: Text(widget.training.abstract ?? ""),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DialogWidget(
                title: "Atenção",
                subTitle: "Deseja apagar este treino?",
                primarylabel: "Confirmar",
                secundaryLabel: "Cancelar",
                primaryFunc: () {
                  FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).collection("training").doc(widget.id).delete();
                  Navigator.pop(context);
                },
                secundaryFunc: () => Navigator.pop(context)
              )
            );
          },
        ),
        onTap: () async {
          FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).collection("training").doc(widget.id).collection("exercises").orderBy("time").get().then((exercises) {
            List<ExerciseEntity> listExercises = [];
            for (QueryDocumentSnapshot<Map<String, dynamic>> e in exercises.docs) {
              listExercises.add(ExerciseEntity.fromMap(e.data()));
            }
            trainingStore.setTraining(
              TrainingEntity(
                name: widget.training.name,
                abstract: widget.training.abstract,
                exercises: listExercises
              )
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CrudTraining()));
          });
        } 
      ),
    );
  }
}