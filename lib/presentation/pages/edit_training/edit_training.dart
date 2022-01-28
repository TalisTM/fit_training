import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/models/training_entity.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_button_widget.dart';
import 'package:fit_training/presentation/pages/crud_training/crud_training.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'widgets/edit_training_tile.dart';

class EditTraining extends StatefulWidget {
  const EditTraining({ Key? key }) : super(key: key);

  @override
  _EditTrainingState createState() => _EditTrainingState();
}

class _EditTrainingState extends State<EditTraining> {

  final userStore = GetIt.I.get<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Treino"),
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
                        FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).update({"qtdTraining": 0});
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).collection("training").orderBy("time").snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                  child: CircularProgressIndicator()
              );
            default:
              List<DocumentSnapshot<Map<String, dynamic>>>? docs = snapshot.data!.docs;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (docs.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Nenhum treino cadastrado",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    if (docs.isNotEmpty)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        primary: false,
                        shrinkWrap: true,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          TrainingEntity training = TrainingEntity.fromMap(docs[index].data()!);
                          return EditTrainingTile(training, docs[index].id);
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
              );
          }
        },
      )
    );
  }
}