import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training/database/database.dart';
import 'package:fit_training/presentation/pages/auth/auth_page.dart';
import 'package:fit_training/presentation/pages/home/home_page.dart';
import 'package:fit_training/presentation/pages/splash/widgets/animated_logo.dart';
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

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin{

  final userStore = GetIt.I.get<UserStore>();
  bool isDarkMode = false;

  late final AnimationController _animationController;

  Future<void> _getDatas() async {
    await Database.load();
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      await FirebaseFirestore.instance.collection("user").doc(user?.uid).get().then((u) async {
        if (u.data() != null) {
          await userStore.loadFirebase(u.data()!);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();    
    var brightness = SchedulerBinding.instance?.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _animationController.forward();

    _getDatas();

    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        if(isLogged()) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AuthPage()), (route) => false);
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover,
        ),
        AnimatedLogo(
          controller: _animationController,
          isDarkMode: isDarkMode
        )
      ],
    );
  }
}