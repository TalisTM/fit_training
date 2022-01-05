import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/presentation/components/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class ExerciseWidget extends StatefulWidget {
  final DocumentSnapshot exercise;
  const ExerciseWidget(this.exercise, {Key? key }) : super(key: key);

  @override
  _ExerciseWidgetState createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {

  final TextEditingController _weightController = TextEditingController();

  bool rest = false;

  int time = 40;
  int timer = 40;

  @override
  void initState() {
    super.initState();
    time = 40;
    timer = 40;

    _weightController.text = widget.exercise["weight"];
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
                if(widget.exercise['done'] == widget.exercise['repeat']) {
                  //mudar a caixa para trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
                  //widget.exercise["check"] = true;
                }
                Navigator.pop(context);
              }
            ),
            Text(
              widget.exercise['name'],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 4),
            Text(
              "${widget.exercise['repeat']} x (${widget.exercise['serie']})",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 15),
            if(rest)
            Column(
              children: [
                Text("Descanso:", style: Theme.of(context).textTheme.subtitle1),
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
                          value: timer / time,
                        ),
                      ),
                      Center(
                        child: Text("00:${timer.toString().padLeft(2, "0")}", style: Theme.of(context).textTheme.subtitle2),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.remove_circle, color: Theme.of(context).primaryColor, size: 40),
                  onPressed: () {
                    if(widget.exercise["done"] > 0) {
                      setState(() {
                        rest = false;
                      });
                      //-1 no doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
                      //widget.exercise["done"] = widget.exercise["done"] - 1;
                    }
                  },
                ),
                Text(widget.exercise['done'].toString(), style: Theme.of(context).textTheme.subtitle1),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.add_circle, color: Theme.of(context).primaryColor, size: 40),
                  onPressed: () async {
                    if(widget.exercise['done'] == widget.exercise['repeat']) {
                      Navigator.pop(context, true);
                      //true no checkkkkkkkkkkkkkkkkkkkkkkkkkkkkkjkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                      //widget.exercise["check"] = true;

                    } else if(widget.exercise['done'] < widget.exercise['repeat']) {
                      setState(() {
                        timer = time;
                      });
                      // +1  no dfoneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
                      //widget.exercise['done']++;

                      if(!rest) {
                        timer = time;
                        setState(() {
                          rest = true;
                        });
                        while(timer > 0) {
                          await Future.delayed(const Duration(seconds: 1)).then((value) {
                            setState(() {
                              timer--;
                            });
                          });
                        }
                        setState(() {
                          rest = false;
                          if(widget.exercise['done'] >= widget.exercise['repeat']) {
                            Navigator.pop(context, true);
                            //check trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
                            //widget.exercise['check'] = true;
                          }
                        });
                      }
                    }
                  }
                )
              ],
            ),
            TextFieldWidget(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              label: "Peso",
              controller: _weightController,
              onChanged: (text) {
                //colocar o pesooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
                //widget.exercise['weight'] = text;
              },
            )
          ],
        ),
      )
    );
  }
}