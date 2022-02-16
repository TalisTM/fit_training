import 'package:fit_training/presentation/pages/edit_training/edit_training.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:animated_card/animated_card.dart';


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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 70,
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
          child: AnimatedCard(
            direction: AnimatedCardDirection.top,
            duration: const Duration(milliseconds: 500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Editar".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Observer(
                  builder: (context) {
                    return Text(
                      "${userStore.user.done ?? "0"} Feitos", 
                      style: Theme.of(context).textTheme.bodyText2
                    );
                  }
                )
              ],
            ),
          )
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const EditTraining()));
      }
    );
  }
}