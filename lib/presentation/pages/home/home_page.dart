import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/database/database.dart';
import 'package:fit_training/presentation/pages/home/widgets/training_tile.dart';
import 'package:fit_training/stores/training/training_store.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'widgets/app_bar_home.dart';
import 'package:animated_card/animated_card.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final userStore = GetIt.I.get<UserStore>();
  final trainingStore = GetIt.I.get<TrainingStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: Observer(
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
            return AnimatedCard(
              direction: AnimatedCardDirection.left,
              duration: const Duration(milliseconds: 400),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: trainingStore.training.length,
                itemBuilder: (context, index) {
                  return TrainingTile(trainingStore.training[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}