import 'package:fit_training/models/exercise_entity.dart';
import 'package:fit_training/models/training_entity.dart';
import 'package:fit_training/presentation/components/widgets/appbar_widget.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_button_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_field_widget.dart';
import 'package:fit_training/presentation/pages/crud_training/widgets/exercise_dialog.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CrudTraining extends StatefulWidget {
  final int? index;
  const CrudTraining({this.index, Key? key }) : super(key: key);

  @override
  _CrudTrainingState createState() => _CrudTrainingState();
}

class _CrudTrainingState extends State<CrudTraining> {

  final userStore = GetIt.I.get<UserStore>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _abstractController = TextEditingController();
  String? _nameErro;
  String? _abstractErro;

  TrainingEntity training = TrainingEntity(
    exercises: []
  );

  @override
  void initState() {
    super.initState();

    if(widget.index != null) {
      training = TrainingEntity.fromMap(userStore.user.training![widget.index!].toMap());
      _nameController.text = training.name!;
      _abstractController.text = training.abstract!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        label: widget.index == null ? "Adicionar Treino" : "Editar ${training.name}",
        onPressedBackButton: () {
          showDialog(
            context: context,
            builder: (context) => DialogWidget(
              title: "Atenção",
              subTitle: "Todas as alterações feitas serão perdidas.",
              primarylabel: "Sair",
              primaryFunc: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              secundaryLabel: "Permanecer",
              secundaryFunc: () => Navigator.pop(context),
            )
          );
        }
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextFieldWidget(
              label: "Nome do treino",
              hintText: "Ex. Treino A",
              autofocus: true,
              errorText: _nameErro,
              onChanged: (_) {
                setState(() {
                  _nameErro = null;
                });
              },
              controller: _nameController
            ),
            TextFieldWidget(
              padding: const EdgeInsets.only(top: 15),
              label: "Descrição (opcional)",
              hintText: "Ex. Peito e tríceps",
              errorText: _abstractErro,
              onChanged: (_) {
                setState(() {
                  _abstractErro = null;
                });
              },
              controller: _abstractController
            ),
            const SizedBox(height: 10),
            if (training.exercises != null)
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: training.exercises?.length,
                itemBuilder: (context, index){
                  return exerciseTile(index);
                  //return CrudExerciseTile(training.exercises![index]);
                },
              ),
            TextButtonWidget(
              label: "Adicionar Exercicio",
              icon: Icons.add,
              onPressed: () async {
                ExerciseEntity? exercise;

                exercise = await showDialog(
                  context: context,
                  builder: (context) => const ExerciseDialog()
                );

                if(exercise != null) {
                  training.exercises!.add(exercise);
                  setState(() {});
                }
              }
            ),
            const SizedBox(height: 50),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        label: Text(widget.index == null ? "Adicionar Treino" : "Editar Treino", style: Theme.of(context).textTheme.headline3),
        icon: Icon(Icons.add, size: 28, color: Theme.of(context).backgroundColor),
        onPressed: () async {
          if(_nameController.text.trim().isEmpty) {
            _nameErro = "Nome inválido";
            setState(() {});
          } else if(training.exercises == null || training.exercises!.isEmpty) {
            showDialog(
              context: context,
              builder: (context) => DialogWidget(
                title: "Atenção",
                subTitle: "Adicione pelo menos um exercício primeiro",
                primarylabel: "Ok",
                primaryFunc: () => Navigator.pop(context),
              )
            );
          } else {
            training.name = _nameController.text.trim();
            if(_abstractController.text.trim().isNotEmpty) training.abstract = _abstractController.text.trim();

            if(widget.index != null) {
              userStore.editTraining(training, widget.index);
            } else {
              userStore.addTraining(training);
            }
            Navigator.pop(context);
          }
        }
      ),
    );
  }

  Widget exerciseTile(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        title: Text(training.exercises![index].name!),
        subtitle: Text(
          "${training.exercises![index].serie} x ${training.exercises![index].repeat} ${training.exercises![index].weight != '' ?  '(${training.exercises![index].weight})' : ''}"
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DialogWidget(
                title: "Atenção",
                subTitle: "Deseja apagar este exercicio?",
                primarylabel: "Confirmar",
                secundaryLabel: "Cancelar",
                primaryFunc: () {
                  training.exercises!.removeAt(index);
                  setState(() {});
                  Navigator.pop(context);
                },
                secundaryFunc: () => Navigator.pop(context)
              )
            );
          },
        ),
        onTap: () async {
          ExerciseEntity? retorno = await showDialog(
            context: context,
            builder: (context) => ExerciseDialog(exercise: training.exercises![index])
          );

          if(retorno != null) {
            training.exercises![index] = retorno;
            setState(() {});
          }
        },
      ),
    );
  }
}