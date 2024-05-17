import 'package:chatapp/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pages/homa_page.dart';
import 'package:chatapp/pages/homa_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
        //   user is logged in
          if(snapshot.hasData){
            return Homepage();
          }

        //   user is not logged in
          else{
            return const Loginorregister();
          }
        },
      ),
    );
  }
}