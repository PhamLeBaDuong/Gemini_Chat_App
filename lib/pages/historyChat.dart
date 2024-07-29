import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:namer_app/components/chatTile.dart';
import 'package:namer_app/features/user_auth/data_implementation/firestore_service.dart';
import 'package:namer_app/pages/chatPage.dart';
import 'package:namer_app/pages/homePages.dart';
import 'package:namer_app/pages/login.dart';

class HistoryChat extends StatefulWidget {
  const HistoryChat({super.key});

  @override
  State<HistoryChat> createState() => _HistoryChatState();
}

class _HistoryChatState extends State<HistoryChat> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat History"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              title = "";
              chatID = "";
              geminiChatHistory = [];
              messages = [];
              controller.selectedIndex.value = 0;
            }),
        body: _buildChatList());
  }

  Widget _buildChatList() {
    return StreamBuilder(
        stream: getChatsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildChatListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildChatListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return Chattile(
        text: userData["title"],
        onTapDelete: () {
          _firestore
              .collection("users")
              .doc(currentID)
              .collection("chatrooms")
              .doc(userData["chatID"])
              .delete();
        },
        onTap: () async {
          if (chatID != userData["chatID"]) {
            List<Part> parts = [];
            List<ChatMessage> newmessages = [];
            title = userData["title"];
            chatID = userData["chatID"];
            var temp = await _firestore
                .collection("users")
                .doc(currentID)
                .collection("chatrooms")
                .doc(chatID)
                .collection("messages")
                .orderBy('timestamp')
                .get();
            bool isUser = true;
            temp.docs.forEach(
              (element) {
                parts.add(TextPart(element["message"]));
                if (isUser) {
                  geminiChatHistory.addIf(true, Content("user", parts));
                  isUser = false;
                  ChatMessage tempM = ChatMessage(
                      user: currentUser,
                      createdAt: (element["timestamp"] as Timestamp).toDate(),
                      text: element["message"]);
                  newmessages = [tempM, ...newmessages];
                } else {
                  geminiChatHistory.addIf(true, Content("model", parts));
                  isUser = true;
                  ChatMessage tempM = ChatMessage(
                      user: geminiUser,
                      createdAt: (element["timestamp"] as Timestamp).toDate(),
                      text: element["message"]);
                  newmessages = [tempM, ...newmessages];
                }
              },
            );
            messages = newmessages;
          }

          controller.selectedIndex.value = 0;
        });
  }

  Stream<List<Map<String, dynamic>>> getChatsStream() {
    return _firestore
        .collection("users")
        .doc(currentID)
        .collection("chatrooms")
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }
}
