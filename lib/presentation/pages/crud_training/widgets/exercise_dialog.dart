import 'package:fit_training/models/exercise_entity.dart';
import 'package:fit_training/presentation/components/widgets/button_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class ExerciseDialog extends StatefulWidget {
  final ExerciseEntity? exercise;
  const ExerciseDialog({ Key? key, this.exercise}) : super(key: key);

  @override
  _ExerciseDialogState createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {

  final TextEditingController _nameController = TextEditingController();
  int _seriecontroller = 1;
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String? _nameError;
  String? _repeatError;

  @override
  void initState() {
    super.initState();

    if(widget.exercise != null) {
      _nameController.text = widget.exercise!.name!;
      _seriecontroller = widget.exercise!.serie!;
      _repeatController.text = widget.exercise!.repeat!;
      _weightController.text = widget.exercise!.weight!;
    }
  }

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
              errorText: _nameError,
              onChanged: (_) {
                setState(() {
                  _nameError = null;
                });
              },
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
              errorText: _repeatError,
              onChanged: (_) {
                setState(() {
                  _repeatError = null;
                });
              },
              controller: _repeatController
            ),
            TextFieldWidget(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              label: "Peso (opcional)",
              controller: _weightController
            ),
            ButtonWidget(
              label: widget.exercise != null ? "Editar" : "Adicionar",
              onPressed: () {
                if(_nameController.text.trim().isEmpty) _nameError = "Nome inválido";
                if(_repeatController.text.trim().isEmpty) _repeatError = "Repetições inválidas";
                if(_weightController.text.trim().isEmpty) _weightController.text = "";
                setState(() {});

                if(_nameError == null && _repeatError == null) {
                  ExerciseEntity exercise = ExerciseEntity(
                    name: _nameController.text.trim(),
                    serie: _seriecontroller,
                    repeat: _repeatController.text.trim(),
                    weight: _weightController.text.trim(),
                    check: false
                  );

                  Navigator.pop(context, exercise);
                } 
              }
            ),
            const SizedBox(height: 10)
          ],
        )
      )
    );
  }
}