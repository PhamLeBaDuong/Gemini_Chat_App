import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:namer_app/components/chatTile.dart';
import 'package:namer_app/features/user_auth/data_implementation/firestore_service.dart';
import 'package:namer_app/pages/chatPage.dart';
import 'package:namer_app/pages/homePages.dart';
import 'package:namer_app/pages/login.dart';

class HistoryChat extends StatefulWidget {
  const HistoryChat({super.key});

  @override
  State<HistoryChat> createState() => _UserprofileState();
}

class _UserprofileState extends State<HistoryChat> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat History"),
      ),
      body: _buildChatList(),
    );
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
        onTap: () {
          title = userData["title"];
          chatID = userData["chatID"];
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
