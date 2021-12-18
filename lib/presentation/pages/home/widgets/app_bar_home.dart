import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(userStore.user.photoUrl!)
                            )
                          ),
                          height: 50,
                          width: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15)
                  ],
                )
              ),
              //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: 30
            ),
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: Theme.of(context).primaryColor,
                      height: 50, 
                    ),
                    Container(
                      color: Colors.white,
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
    );
  }
}