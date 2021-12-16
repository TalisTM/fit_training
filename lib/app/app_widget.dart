import 'package:firebase_core/firebase_core.dart';
import 'package:fit_training/presentation/pages/auth/auth_page.dart';
import 'package:fit_training/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return const Text("erro :(");
        }
        if(snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Fit Training",
            home: AuthPage(),
          );
        }

        return const CircularProgressIndicator();
      }
    );
  }
}