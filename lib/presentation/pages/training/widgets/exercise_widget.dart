import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/presentation/components/widgets/text_field_widget.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ExerciseWidget extends StatefulWidget {
  final DocumentSnapshot data;
  const ExerciseWidget(this.data, {Key? key }) : super(key: key);

  @override
  _ExerciseWidgetState createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {

  final TextEditingController _weightController = TextEditingController();

  Timer? timer;
  int conter = 0;

  int done = 0;

  final userStore = GetIt.I.get<UserStore>();

  DocumentSnapshot? exercise;

  @override
  void initState() {    
    super.initState();
    exercise = widget.data;

    widget.data.reference.snapshots().listen((e) {
        exercise = e;
      });

    _weightController.text = exercise!["weight"];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.close, color: Theme.of(context).primaryColor, size: 30),
              onPressed: () {
                if(done == exercise!['repeat']) {
                  widget.data.reference.update(
                    {
                      "check": true
                    }
                  );
                }
                if(timer != null) timer!.cancel();
                Navigator.pop(context);
              }
            ),
            Text(
              exercise!['name'],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 4),
            Text(
              "${exercise!['serie']} x (${exercise!['repeat']})",
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
                    if(done > 0) {
                      done--;
                      if(timer != null) timer!.cancel();
                      conter = 0;
                      setState(() {});
                    }
                  },
                ),
                Text(done.toString(), style: Theme.of(context).textTheme.subtitle1),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.add_circle, color: Theme.of(context).primaryColor, size: 40),
                  onPressed: () async {
                    if(done == exercise!['serie']) {
                      if(timer != null) timer!.cancel();
                      Navigator.pop(context, true);
                      widget.data.reference.update(
                        {
                          "check": true
                        }
                      );

                    } else if(done < exercise!['serie']) {
                      done++;
                      setState(() {});

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

                        if(done >= exercise!['serie'] && conter == 0) {
                          timer.cancel();
                          Navigator.pop(context, true);
                          widget.data.reference.update(
                            {
                              "check": true
                            }
                          );
                        }
                      });
                    }
                  }
                )
              ],
            ),
            Column(
              children: [
                //Text("Descanso:", style: Theme.of(context).textTheme.subtitle1),
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
                          backgroundColor: Colors.grey[300],
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
                widget.data.reference.update(
                  {
                    "weight": text
                  }
                );
              },
            ),
          ],
        )
      )
    );
  }
}