import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/pages/crud_training/crud_training.dart';
import 'package:fit_training/stores/training/training_store.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditTrainingTile extends StatefulWidget {
  final int index;
  const EditTrainingTile(
    this.index,
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
        title: Text(trainingStore.training[widget.index].name ?? ""),
        subtitle: Text(trainingStore.training[widget.index].abstract ?? ""),
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
                  trainingStore.training.removeAt(widget.index);
                  Navigator.pop(context);
                },
                secundaryFunc: () => Navigator.pop(context)
              )
            );
          },
        ),
        onTap: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CrudTraining(index: widget.index)));
        } 
      ),
    );
  }
}