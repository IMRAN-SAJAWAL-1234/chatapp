import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/mytextfield.dart';
import '../services/auth/auth_service.dart';

class Loginpage extends StatelessWidget {

  // email and pw text controller
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();

  // tap to goto register page
  void Function()? onTap;

  Loginpage({super.key, required this.onTap});

  // login method
  void login(BuildContext context) async{
  //  auth service
    final authService = AuthService();

  //   try login
    try{
      await authService.signInWithEmailPassword(_emailcontroller.text, _pwcontroller.text);
    }

  //   catch any error
    catch(e){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Theme.of(context).colorScheme.background,
         body: Center(
           child: SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 //logo
                   Icon(
                   Icons.message,
                   size:60,
                   color: Theme.of(context).colorScheme.primary,
                   ),
             
                   // welcome message
                   const SizedBox(height: 50),
                 //   welcom text message
                   Text(
                     "welcome back",
                     style: TextStyle(
                       color: Theme.of(context).colorScheme.primary,
                       fontSize: 16,
                     ),
                   ),
             
                 const SizedBox(height:25),
             
               //   email textfield
               Mytextfield(
                 hinttext: "Email",
                 obscuretext: false,
                 controller: _emailcontroller,
               ),
             
                 const SizedBox(height:10),
             
               //   pw textfield
                 Mytextfield(
                   hinttext: "Password",
                   obscuretext: true,
                   controller: _pwcontroller,
                 ),
             
                 const SizedBox(height:25),
             
               //   login button
                 Mybutton(
                   text: "Login",
                   onTap: () => login(context),
                 ),
             
                 const SizedBox(height:25),
             
               //   register now
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children:[
               Text(
                "not a member?",
                 style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                    " Register now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                     ),
                    ),
                   ),
                 ],
                ),
               ],
             ),
           ),
         ),
    );
  }
}
