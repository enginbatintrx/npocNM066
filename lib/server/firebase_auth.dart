import 'package:firebase_auth/firebase_auth.dart';

class firebaseAuth {
  FirebaseAuth auth = FirebaseAuth.instance;

  login() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
