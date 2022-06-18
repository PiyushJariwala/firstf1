import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstf1/util/constveriabal.dart';
import 'package:firstf1/util/sharedUID.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login_Register {

  FirebaseAuth auth = FirebaseAuth.instance;

  static Login_Register l1 = Login_Register();

  void signUp(String email, String password) {
    auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  void singIn(BuildContext context,String email, String password) async{
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Navigator.pushNamed(context, '/logout'));
  }

  void curruntUser(BuildContext context)
  {
    if(auth.currentUser != null)
    {
      Navigator.pushReplacementNamed(context, '/logout');
    }
  }

  void singOut()
  {
    auth.signOut();
  }


  void googlelogin(BuildContext context)
  async{
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    var credential =  GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential).then((value) => Navigator.pushReplacementNamed(context, '/logout'));
  }
}
