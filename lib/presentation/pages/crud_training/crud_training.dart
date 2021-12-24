import 'package:fit_training/presentation/components/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class CrudTraining extends StatefulWidget {
  //final 
  const CrudTraining({ Key? key }) : super(key: key);

  @override
  _CrudTrainingState createState() => _CrudTrainingState();
}

class _CrudTrainingState extends State<CrudTraining> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(label: "Adicionar Treino"),
    );
  }
}