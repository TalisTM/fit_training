import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/presentation/components/widgets/appbar_widget.dart';
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
      appBar: const AppBarWidget(label: "Editar Treino"),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).collection("training").orderBy("time").snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                  child: CircularProgressIndicator()
              );
            default:
              List<DocumentSnapshot>? docs = snapshot.data!.docs;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return EditTrainingTile(docs[index]);
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