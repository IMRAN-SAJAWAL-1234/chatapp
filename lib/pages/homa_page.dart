// import 'dart:nativewrappers/_internal/vm/lib/mirrors_patch.dart';

import 'package:chatapp/components/user_tile.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_drawer.dart';
import 'package:flutter/material.dart';

import '../services/chat/chat_service.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // chat & auth servic
  // void logout(){
  // //   get auth service
  //   final _auth = AuthService();
  //   _auth.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        actions: [
        //   logout button
        //   IconButton(onPressed: logout, icon: Icon(Icons.logout))
        ],
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

    //   build a list of users ecept for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
    stream: _chatService.getUserStream(),
    builder: (context, snapshot) {
    //   error
    if (snapshot.hasError) {
    return Text('Error:');
    }

    //   loading
    if (snapshot.connectionState == ConnectionState.waiting) {
       return Text('Loading...');
    }

    //     return list view
    return ListView(
    children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context))
        .toList(),
        );
      },
    );
    }

      //   build individual list tile for user
       Widget _buildUserListItem(Map<String, dynamic> userData,BuildContext context){
       //     display all user except current user
         if(userData["email"]!= _authService.getCurrentUser()!.email) {
           return UserTile(
             text: userData["email"],
             onTap: () {
               Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) =>
                         ChatPage(
                           receiverEmail: userData["email"],
                           receiverID: userData["uid"],
                         ),
                   ));
             },
           );
         }
         else{
           return Container();
         }
      }
    }
