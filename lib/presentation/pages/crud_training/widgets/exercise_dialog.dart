import 'package:fit_training/presentation/components/widgets/button_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class ExerciseDialog extends StatefulWidget {
  const ExerciseDialog({ Key? key }) : super(key: key);

  @override
  _ExerciseDialogState createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {

  final TextEditingController _nameController = TextEditingController();
  int _seriecontroller = 1;
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text("Adicionar Exercicio", style: Theme.of(context).textTheme.headline6),
            TextFieldWidget(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              label: "Nome",
              controller: _nameController
            ),
            Text("Quantidade de Séries", style: Theme.of(context).textTheme.headline2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.remove_circle, color: Theme.of(context).primaryColor, size: 25),
                  onPressed: () {
                    if(_seriecontroller > 1) {
                      setState(() {
                        _seriecontroller--;
                      });
                    }
                  },
                ),
                Text(_seriecontroller.toString(), style: Theme.of(context).textTheme.headline2),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.add_circle, color: Theme.of(context).primaryColor, size: 25),
                  onPressed: () {
                    setState(() {
                      _seriecontroller++;
                    });
                  },
                )
              ],
            ),
            TextFieldWidget(
              padding: const EdgeInsets.only(top: 15),
              label: "Repetições",
              controller: _repeatController
            ),
            TextFieldWidget(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              label: "Peso",
              controller: _weightController
            ),
            ButtonWidget(
              label: "Adicionar",
              onPressed: () {}
            ),
            const SizedBox(height: 10)
          ],
        )
      )
    );
  }
}