import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async{
    final enteredMessage = _messageController.text;
    if(enteredMessage.trim().isEmpty){
      return;
    }
    //send to firebase
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    FirebaseFirestore.instance.collection('chat').add({
      'text' : enteredMessage,
      'createdAt' : Timestamp.now(),
      'userId' : user.uid,
      'userName' : userData.data()!['username'],
      'userImage' : userData.data()!['imageUrl']

    });
    _messageController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(labelText: 'Start typing...'),
          )),
          IconButton(
            onPressed: _submitMessage,
            icon: const Icon(Icons.send_rounded),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }
}