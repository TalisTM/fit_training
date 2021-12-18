import 'package:firebase_core/firebase_core.dart';
import 'package:fit_training/presentation/pages/splash/splash_page.dart';
import 'package:fit_training/theme/app_theme.dart';
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Fit Training",
            theme: AppTheme.lightTheme,
            home: const SplashPage(),
          );
        }

        return const CircularProgressIndicator();
      }
    );
  }
}