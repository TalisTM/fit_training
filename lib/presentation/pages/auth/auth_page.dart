import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training/database/database.dart';
import 'package:fit_training/models/user_entity.dart';
import 'package:fit_training/presentation/pages/home/home_page.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:fit_training/utils/is_logged.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({ Key? key }) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final userStore = GetIt.I.get<UserStore>();

  final GoogleSignIn googleSignIn = GoogleSignIn();

  void _login() async {
    if(isLogged()) return;

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      final User user = userCredential.user!;
      
      bool existe = false;
      await FirebaseFirestore.instance.collection("user").get().then((v) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =  v.docs;
        for (var u in docs) {
          if(u.data()['uid'] == user.uid) {
            existe = true;
          }
        }
      });

      userStore.setUser(
        UserEntity(
          uid: user.uid,
          name: user.displayName,
          email: user.email,
          photoUrl: user.photoURL,
          done: 0
        )
      );
      await Database.saveUser();

      if (!existe) {
        FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).set(userStore.user.toMap());
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false
      );

    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Fit Training",
              textAlign: TextAlign.center, 
              style: Theme.of(context).textTheme.headline1,
            ),
            Image.asset("assets/images/icon.png", height: 250),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),  
                      border: Border.all(
                        color: Colors.grey[400]!,
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset("assets/images/logo_google.png", width: 30),
                        ),
                        Container(
                          color: Colors.grey[400],
                          width: 1,
                          height: 40
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Login com Google",
                            style: Theme.of(context).textTheme.headline2
                            ,
                          ),
                        )
                      ],
                    ),
                  ),
                  onPressed: _login,
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}