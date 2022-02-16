import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_button_widget.dart';
import 'package:fit_training/presentation/pages/crud_training/crud_training.dart';
import 'package:fit_training/stores/training/training_store.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'widgets/edit_training_tile.dart';

class EditTraining extends StatefulWidget {
  const EditTraining({ Key? key }) : super(key: key);

  @override
  _EditTrainingState createState() => _EditTrainingState();
}

class _EditTrainingState extends State<EditTraining> {

  final userStore = GetIt.I.get<UserStore>();
  final trainingStore = GetIt.I.get<TrainingStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Treinos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton(
            color: Theme.of(context).backgroundColor,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text("Zerar número de feitos"),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => DialogWidget(
                      title: "Atenção",
                      subTitle: "Tem certeza que deseja zerar o número de treinos feitos",
                      primarylabel: "Confirmar",
                      secundaryLabel: "Cancelar",
                      primaryFunc: () {
                        userStore.resetDone(); //atualizxar o bancoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
                        Navigator.pop(context);
                      },
                      secundaryFunc: () => Navigator.pop(context)
                    )
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CrudTraining())); //provisórioooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
                }
              )
            ]
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Observer(
              builder: (context) {
                if(trainingStore.training.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Nenhum treino cadastrado",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: trainingStore.training.length,
                    itemBuilder: (context, index) {
                      return EditTrainingTile(index);
                    },
                  );
                }
              },
            ),
            TextButtonWidget(
              label: "Adicionar treino",
              icon: Icons.add,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CrudTraining()));
              }
            )
          ],
        ),
      )
    );
  }
}