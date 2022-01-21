import 'package:fit_training/presentation/pages/edit_training/edit_training.dart';
import 'package:flutter/material.dart';

class AbstractData extends StatelessWidget {
  const AbstractData({
    Key? key,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
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
            Text(
              "20 Feitos",
              style: Theme.of(context).textTheme.bodyText2, 
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