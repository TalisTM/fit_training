import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training/models/user_entity.dart';
import 'package:fit_training/presentation/components/widgets/dialog_widget.dart';
import 'package:fit_training/presentation/pages/auth/auth_page.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:animated_card/animated_card.dart';

import 'abstract_data.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {

  const AppBarHome({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(300);

  @override
  Widget build(BuildContext context) {

    final userStore = GetIt.I.get<UserStore>();

    return PreferredSize(
      preferredSize: const Size.fromHeight(300),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    AnimatedCard(
                      direction: AnimatedCardDirection.left,
                      duration: const Duration(milliseconds: 400),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(userStore.user.photoUrl!)
                                  )
                                ),
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(width: 15),
                              Text.rich(
                                TextSpan(
                                  text: "Olá, ",
                                  style: Theme.of(context).textTheme.headline4,
                                  children: [
                                    TextSpan(
                                      text: userStore.user.name,
                                      style: Theme.of(context).textTheme.headline3
                                    )
                                  ]
                                )
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.logout_outlined, color: Theme.of(context).splashColor, size: 30,),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => DialogWidget(
                                      title: "Atenção",
                                      subTitle: "Tem certeza que deseja deslogar do aplicativo?",
                                      primarylabel: "Confirmar",
                                      secundaryLabel: "Cancelar",
                                      primaryFunc: () async {
                                        await FirebaseAuth.instance.signOut();
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPage()));
                                        userStore.setUser(UserEntity());
                                      }, 
                                      secundaryFunc: () => Navigator.pop(context)
                                    )
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15)
                  ],
                )
              ),
              const SizedBox(height: 5),
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Theme.of(context).primaryColor,
                        height: 40, 
                      ),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        height: 50,
                      ),
                    ],
                  ),
                  const AbstractData()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}