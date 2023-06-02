import 'package:autism_helper_project/screens/sign_in/sign_in_page.dart';
import 'package:autism_helper_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/auth.dart';
import 'Home/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBase? auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
        stream: auth?.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (kDebugMode) {
              print("ID : ${user?.uid}");
            }
            if (user == null) {
              return SignInPage();
            }
            return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: const HomePage(),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
