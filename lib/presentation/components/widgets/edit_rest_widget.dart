import 'package:fit_training/presentation/components/widgets/button_widget.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/components/widgets/text_field_widget.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditRestWidget extends StatefulWidget {
  const EditRestWidget({ Key? key }) : super(key: key);

  @override
  State<EditRestWidget> createState() => _EditRestWidgetState();
}

class _EditRestWidgetState extends State<EditRestWidget> {

  final userStore = GetIt.I.get<UserStore>();
  final TextEditingController rest = TextEditingController();

  @override
  void initState() {
    super.initState();
    rest.text = userStore.user.rest.toString();
  }
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tempo de Descanso", style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 10),
              Text("Digite abaixo o tempo em segundos:", style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 15),
              TextFieldWidget(
                controller: rest,
                label: "Digite o tempo (segundos)",
                hintText: "Ex: 40",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              ButtonWidget(
                label: "Confirmar",
                onPressed: () {
                  if(rest.text.trim().isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => DialogWidget(
                        title: "Tempo inválido",
                        subTitle: "Digite algum valor no campo.",
                        primarylabel: "Ok",
                        primaryFunc: () async {
                          Navigator.pop(context);
                        },
                      )
                    );
                  }
                  else {
                    userStore.setRest(int.parse(rest.text));
                    Navigator.pop(context);
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}