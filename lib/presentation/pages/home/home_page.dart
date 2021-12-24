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
      // body: Observer(
      //   builder: (context) {
      //     return ListView.builder(
      //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //       itemCount: trainingStore.treino['series'].length,
      //       itemBuilder: (context, index) {
      //         return Card(
      //           margin: const EdgeInsets.symmetric(vertical: 10),
      //           child: TrainingTile(
      //             indexSerie: index
      //           )
      //         );
      //       },
      //     );
      //   }
      // )
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).collection("training").snapshots(),
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
                  primary: false,
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return TrainingTile(docs[index]);
                  },
                );
            }
          },
      )
    );
  }
}