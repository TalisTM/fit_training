import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/presentation/pages/edit_training/edit_training.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AbstractData extends StatefulWidget {
  const AbstractData({Key? key}) : super(key: key);

  @override
  State<AbstractData> createState() => _AbstractDataState();
}

class _AbstractDataState extends State<AbstractData> {
  final userStore = GetIt.I.get<UserStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF393E46).withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Editar".toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    return Text(
                      "${snapshot.data?["qtdTraining"]} Feitos", 
                      style: Theme.of(context).textTheme.bodyText2
                    );
                }
              }
            )
          ],
        )
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const EditTraining()));
      }
    );
  }
}