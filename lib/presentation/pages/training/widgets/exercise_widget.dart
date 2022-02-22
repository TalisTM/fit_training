import 'dart:async';

import 'package:fit_training/database/database.dart';
import 'package:fit_training/models/exercise_entity.dart';
import 'package:fit_training/presentation/components/widgets/text_field_widget.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ExerciseWidget extends StatefulWidget {
  final ExerciseEntity exercise;
  const ExerciseWidget(this.exercise, {Key? key }) : super(key: key);

  @override
  _ExerciseWidgetState createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {

  final TextEditingController _weightController = TextEditingController();

  Timer? timer;
  int conter = 0;

  final userStore = GetIt.I.get<UserStore>();

  @override
  void initState() {    
    super.initState();
    _weightController.text = widget.exercise.weight!;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).primaryColor, size: 35),
            onPressed: () {
              if(widget.exercise.done == widget.exercise.serie) {
              }
              if(timer != null) timer!.cancel();
              Navigator.pop(context);
            }
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).splashColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.exercise.name!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 4),
                Text(
                  "${widget.exercise.serie} x (${widget.exercise.repeat})",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.remove_circle, color: Theme.of(context).primaryColor, size: 40),
                      onPressed: () {
                        if(widget.exercise.done! > 0) {
                          widget.exercise.done = widget.exercise.done! - 1;
                          setState(() {});
                          Database.saveTraining();
                          if(timer != null) timer!.cancel();
                          conter = 0;
                          setState(() {});
                        }
                      },
                    ),
                    Text(widget.exercise.done.toString(), style: Theme.of(context).textTheme.subtitle1),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.add_circle, color: Theme.of(context).primaryColor, size: 40),
                      onPressed: () async {
                        if(widget.exercise.done == widget.exercise.serie) {
                          if(timer != null) timer!.cancel();
                          Navigator.pop(context, true);
                          widget.exercise.check = true;
                          setState(() {});
                          Database.saveTraining();

                        } else if(widget.exercise.done! < widget.exercise.serie!) {
                          widget.exercise.done = widget.exercise.done! + 1;
                          setState(() {});
                          Database.saveTraining();

                          conter = 40;
                          if(timer != null) timer!.cancel();
                          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                            setState(() {
                              if(conter > 0) {
                                conter--;
                              } else {
                                timer.cancel();
                              }
                            });

                            if(widget.exercise.done! >= widget.exercise.serie! && conter == 0) {
                              timer.cancel();
                              Navigator.pop(context, true);
                              widget.exercise.check = true;
                              setState(() {});
                              Database.saveTraining();
                            }
                          });
                        }
                      }
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 70,
                      width: 70,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: CircularProgressIndicator(
                              strokeWidth: 10,
                              backgroundColor: Theme.of(context).hintColor,
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                              value: conter / 40,
                            ),
                          ),
                          Center(
                            child: Text("${conter.toString()}s", style: Theme.of(context).textTheme.subtitle2),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                TextFieldWidget(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  label: "Peso",
                  controller: _weightController,
                  onChanged: (text) {
                    widget.exercise.weight = text;
                    setState(() {});
                    Database.saveTraining();
                  },
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}