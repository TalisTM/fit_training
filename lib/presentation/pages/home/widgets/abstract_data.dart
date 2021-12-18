import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AbstractData extends StatelessWidget {
  const AbstractData({
    Key? key,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      // child: Observer(
      //   builder: (context) {
      //     return Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         Text(
      //           trainingStore.treino['name'],
      //           style: Theme.of(context).textTheme.headline4,
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: LinearProgressIndicator(
      //                 backgroundColor: Colors.grey[300],
      //                 valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      //                 value: trainingStore.treino['quantity'] / trainingStore.treino['maxQuantity'],
      //               ),
      //             ),
      //             const SizedBox(width: 10),
      //             Text(
      //               trainingStore.treino['quantity'].toString() + "/" + trainingStore.treino['maxQuantity'].toString(),
      //               style: Theme.of(context).textTheme.subtitle2,
      //             )
      //           ],
      //         )
      //       ],
      //     );
      //   }
      // )
    );
  }
}