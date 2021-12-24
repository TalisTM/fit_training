import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/pages/training/training_page.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditTrainingTile extends StatefulWidget {
  final DocumentSnapshot data;

  const EditTrainingTile(
    this.data,
    {
    Key? key
    }) : super(key: key);

  @override
  State<EditTrainingTile> createState() => _EditTrainingTileState();
}

class _EditTrainingTileState extends State<EditTrainingTile> {

  final userStore = GetIt.I.get<UserStore>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.data['name']),
      subtitle: Text(widget.data['abstract']),
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

              },
              secundaryFunc: () => Navigator.pop(context)
            )
          );
        },
      ),
      onTap: () async {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingPage(widget.data)));
      } 
    );
  }
}