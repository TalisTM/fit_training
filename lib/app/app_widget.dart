import 'package:firebase_core/firebase_core.dart';
import 'package:fit_training/presentation/pages/splash/splash_page.dart';
import 'package:fit_training/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({ Key? key }) : super(key: key);

  Future<void> _gets() async {
    await Firebase.initializeApp();

    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _gets(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return const Text("erro :(");
        }
        if(snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Fit Training",
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: const SplashPage(),
          );
        }

        return const CircularProgressIndicator();
      }
    );
  }
}