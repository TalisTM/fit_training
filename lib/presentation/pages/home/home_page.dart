import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/presentation/pages/home/widgets/training_tile.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'widgets/app_bar_home.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final userStore = GetIt.I.get<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
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
                if (docs.isEmpty) {
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
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      return TrainingTile(docs[index]);
                    },
                  );
                }
            }
          },
      )
    );
  }
}