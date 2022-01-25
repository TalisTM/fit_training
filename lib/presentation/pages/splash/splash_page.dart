import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training/models/user_entity.dart';
import 'package:fit_training/presentation/pages/auth/auth_page.dart';
import 'package:fit_training/presentation/pages/home/home_page.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:fit_training/utils/is_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final userStore = GetIt.I.get<UserStore>();
  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();    
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    FirebaseAuth.instance.authStateChanges().listen((user) {
      userStore.setUser(
        UserEntity(
          uid: user?.uid,
          name: user?.displayName,
          email: user?.email,
          photoUrl: user?.photoURL
        )
      );
    });

    Future.delayed(const Duration(seconds: 1)).then((value) {
      if(isLogged()) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDarkMode
      ? Image.asset(
        'assets/images/splash-dark.png',
        fit: BoxFit.cover,
      )
      : Image.asset(
        'assets/images/splash.png',
        fit: BoxFit.cover,
      );
  }
}