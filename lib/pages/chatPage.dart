import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namer_app/features/user_auth/data_implementation/firestore_service.dart';
import 'package:namer_app/pages/homePages.dart';
import 'package:namer_app/pages/userProfile.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final chat = GenerativeModel(
          model: "gemini-pro",
          apiKey: "AIzaSyAqa3TgDPWoGywDrm3poSg_pgtSRfCHMm0")
      .startChat(history: geminiChatHistory);
  Future<void> editChatTitle() async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text(
                "Edit Title",
                style: TextStyle(color: Colors.white),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Enter new title",
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
    if (newValue.trim().isNotEmpty) {
      //title = newValue;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentID)
          .collection("chatrooms")
          .doc(chatID)
          .update({"title": newValue});
      setState(() {
        title = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: editChatTitle,
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ],
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
        title: Text(
          title == "" ? "New Chat" : title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: DashChat(
          messageOptions:
              MessageOptions(currentUserContainerColor: Colors.grey[800]),
          inputOptions: InputOptions(trailing: [
            IconButton(
                onPressed: _sendMediaMessage, icon: const Icon(Icons.image)),
          ]),
          messages: messages,
          currentUser: currentUser,
          onSend: _sendMessage),
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    final userCollection = FirebaseFirestore.instance.collection("users");
    Message newMessage =
        Message(timestamp: Timestamp.now(), message: chatMessage.text);
    if (chatID == "") {
      try {
        var temp = chat;
        String question = "give me the title for this question: ";
        question += chatMessage.text;
        var responsee = await temp.sendMessage(Content.text(question));

        title = responsee.text!;
        String id = userCollection.doc().id;
        chatID = id;

        userCollection
            .doc(currentID)
            .collection("chatrooms")
            .doc(chatID)
            .set(ChatRoom(
              title: title,
              chatID: chatID,
              timestamp: Timestamp.now(),
            ).toMap());
      } catch (e) {
        print(e);
      }
    }
    userCollection
        .doc(currentID)
        .collection("chatrooms")
        .doc(chatID)
        .collection("messages")
        .add(newMessage.toMap());
    try {
      List<Uint8List>? images;
      // if (chatMessage.medias?.isNotEmpty ?? false) {
      //   images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      // }
      var response = await chat.sendMessage(Content.text(chatMessage.text));

      // gemini.streamGenerateContent(question, images: images).listen((event) {
      //   ChatMessage? lastMassage = messages.firstOrNull;
      //   if (lastMassage != null && lastMassage.user == geminiUser) {
      //     lastMassage = messages.removeAt(0);
      //     String response = event.content?.parts?.fold(
      //             "", (previous, current) => "$previous ${current.text}") ??
      //         "";
      //     lastMassage.text += response;
      //     setState(() {
      //       messages = [lastMassage!, ...messages];
      //     });
      //   } else {
      //     String response = event.content?.parts?.fold(
      //             "", (previous, current) => "$previous ${current.text}") ??
      //         "";
      ChatMessage message = ChatMessage(
          user: geminiUser, createdAt: DateTime.now(), text: response.text!);

      Message responseMessage =
          Message(timestamp: Timestamp.now(), message: response.text);
      userCollection
          .doc(currentID)
          .collection("chatrooms")
          .doc(chatID)
          .collection("messages")
          .add(responseMessage.toMap());
      geminiChatHistory = chat.history.toList();

      setState(() {
        messages = [message, ...messages];
      });
      //   }
      // });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          medias: [
            ChatMedia(url: file.path, fileName: "", type: MediaType.image)
          ]);
      _sendMessage(chatMessage);
    }
  }

  // Stream<List<UserModel>> _readData() {
  //   final userCollection = FirebaseFirestore.instance.collection("users");

  //   return userCollection.snapshots().map((qureySnapshot) => qureySnapshot.docs
  //       .map(
  //         (e) => UserModel.fromSnapshot(e),
  //       )
  //       .toList());
  // }

  // void _createData(UserModel userModel) {
  //   final userCollection = FirebaseFirestore.instance.collection("users");

  //   String id = userCollection.doc().id;

  //   currentID = id;

  //   final newUser = UserModel(
  //     email: userModel.email,
  //     id: id,
  //   ).toJson();

  //   userCollection.doc(id).set(newUser);
  // }

  // void _updateData(UserModel userModel) {
  //   final userCollection = FirebaseFirestore.instance.collection("users");

  //   final newData = UserModel(
  //     email: userModel.email,
  //     id: userModel.id,
  //   ).toJson();

  //   userCollection.doc(userModel.id).update(newData);
  // }

  // void _deleteData(String id) {
  //   final userCollection = FirebaseFirestore.instance.collection("users");

  //   userCollection.doc(id).delete();
  // }
}
