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
        height: 100,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Finalizados",
              style: Theme.of(context).textTheme.headline5,
            ),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    value: 21 / 40, //colocar vquantidade treinada e quantidade limite de treino que pode ser configirada no perfil
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "21/40",                                              //aqui tbm manooo
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
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