import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/components/mytextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {

  final String receiverEmail;
  final String receiverID;

   ChatPage({
    super.key,
    required this.receiverEmail, 
    required this.receiverID,
  });

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send message
  void sendMessage() async{
  //   if there is something inside the test field
    if(_messageController.text.isNotEmpty){
    //   send the message
      await _chatService.sendMessage(receiverID, _messageController.text);

    //   clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
        //   dislay all message
          Expanded(
              child: _buildMessageList(),
          ),

          //   user input
          _buildUserInput(),

        ],
      ),
    );
  }

//   build message list()
Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot){
        //   if er  rors
          if(snapshot.hasError){
            return const Text("error");
          }

        //   loading
          if(snapshot.connectionState == ConnectionState.waiting){
              return const Text("Loading ...");
              }

          //   return list view
            return  ListView(
              children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
            );
          },
    );
  }

//   build message item
    Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data =  doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // align mesaage to right if  sender is  current user, otherwise left
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
       child:Column(
         crossAxisAlignment:isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
         children: [
           ChatBubble(message: (data["message"]), isCurrentUser: isCurrentUser)
         ],
       )
    );
    }

    // build message input
      Widget _buildUserInput(){
        return Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Row(
            children: [
            //   textfield should take most of the space
              Expanded(
                  child: Mytextfield(
                      hinttext: "Type a message",
                      obscuretext: false,
                      controller: _messageController
                  ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(right: 25),
                child: IconButton(
                    onPressed: sendMessage,
                    icon:const Icon(
                        Icons.arrow_upward,
                    color: Colors.white,)
                ),
              )
            ],
          ),
        );
      }
}
