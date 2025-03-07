import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:flutter/material.dart';

class Loginorregister extends StatefulWidget {
  const Loginorregister({super.key});

  @override
  State<Loginorregister> createState() => _LoginorregisterState();
}

class _LoginorregisterState extends State<Loginorregister> {
  // initially, show login page
  bool showLoginPage = true;

  // toggle between login ad register page
  void togglePages(){
    setState(() {
      showLoginPage =! showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
   if(showLoginPage){
     return Loginpage(
       onTap: togglePages,
     );
   }else {
     return Registerpage(
       onTap: togglePages,
     );
   }
  }
}
