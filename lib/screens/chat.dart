import 'package:blabberfy/widgets/chat_message.dart';
import 'package:blabberfy/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNoti() async{
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
    // final token = await fcm.getToken();
    // print(token); 
  }
  @override
  void initState() {
    super.initState();
    setupPushNoti();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blaberfy',
          style: GoogleFonts.playfairDisplay(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 25,
              )),
              
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Column(
        children: [
          Expanded(child: ChatMessages()),
          NewMessage()
        ],
      )
    );
  }
}
