import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flora/Pages/home_page.dart';
import 'package:flora/Pages/list_of_items_page.dart';
import 'package:flora/Pages/login_page.dart';
import 'package:flora/Pages/register_page.dart';
import 'package:flora/firebase_options.dart';
import 'package:flutter/material.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class Auth{
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;
  Stream <User?> get authStateChanges => auth.authStateChanges();
  Future<void> signInWithEmailAndPassword(
    {
      required String email,
      required String password
    }
  
  ) async {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password);
  }
  Future<void> CreateUserWithEmailAndPassword(
    {
      required String email,
      required String password
    }
  ) async{
    auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async{
    await auth.signOut();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
