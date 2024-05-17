// import 'package:chatapp/auth/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/mytextfield.dart';
import '../services/auth/auth_service.dart';

class Registerpage extends StatelessWidget {
  // email and pw text controller
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();
  final TextEditingController _confirmpwcontroller = TextEditingController();

  // tap to goto register page
  void Function()? onTap;

  Registerpage({super.key, required this.onTap});

void register(BuildContext context){
    //   get auth service
    final _auth= AuthService();

  //   if password match create user
  if(_pwcontroller.text == _confirmpwcontroller.text){
    try{
      _auth.signUpWithEmailPassword(_emailcontroller.text, _pwcontroller.text);
    }
    catch(e){
      showDialog(
          context: context,
          builder: (context) =>const  AlertDialog(
            title: Text("password dont match"),
          )
      );
    }
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
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
              "lets create an account for you",
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

            const SizedBox(height:10),

            //  confirm pw textfield
            Mytextfield(
              hinttext: "Confirm password",
              obscuretext: true,
              controller: _confirmpwcontroller,
            ),


            const SizedBox(height:25),

            //   login button
            Mybutton(
              text: "Register",
              onTap: () => register(context),
            ),

            const SizedBox(height:25),

            //   register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text(
                  "Already have an account?",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " Login now",
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
    );
  }
}
