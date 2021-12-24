import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ExerciseTile extends StatefulWidget {
  final DocumentSnapshot data;
  const ExerciseTile(this.data, {Key? key }) : super(key: key);

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.data['name']),
      subtitle: Text(
        "${widget.data["serie"]} x ${widget.data["repeat"]} ${widget.data["weight"] != '' ?  '(${widget.data["weight"]})' : ''}"
      ),
      trailing: Observer(
        builder: (context) {
          return Checkbox(
            value: widget.data["check"],
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              
            },
          );
        }
      ),
      onTap: () async {
        // var retorno = await showDialog(
        //   context: context,
        //   barrierDismissible: false,
        //   builder: (context) => ExerciseWidget(
        //     indexSerie: widget.indexSerie,
        //     indexExercise: widget.indexExercise,
        //   )
        // );
        // if(retorno != null && retorno) {
        //   trainingStore.treino['series'][widget.indexSerie]['exercise'][widget.indexExercise]['check'] = true;
        // }
      },
    );
  }
}