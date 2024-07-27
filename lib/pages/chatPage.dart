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
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return DashChat(
        inputOptions: InputOptions(trailing: [
          IconButton(
              onPressed: _sendMediaMessage, icon: const Icon(Icons.image)),
        ]),
        messages: messages,
        currentUser: currentUser,
        onSend: _sendMessage);
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
        userCollection.doc(currentID).collection("chatrooms").doc(chatID).set(
            ChatRoom(title: title, chatID: chatID, timestamp: Timestamp.now())
                .toMap());
        userCollection
            .doc(currentID)
            .collection("chatrooms")
            .doc(chatID)
            .collection("messages")
            .add(newMessage.toMap());
      } catch (e) {
        print(e);
      }
    } else {
      userCollection
          .doc(currentID)
          .collection("chatrooms")
          .doc(chatID)
          .collection("messages")
          .add(newMessage.toMap());
    }
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

  Stream<List<UserModel>> _readData() {
    final userCollection = FirebaseFirestore.instance.collection("users");

    return userCollection.snapshots().map((qureySnapshot) => qureySnapshot.docs
        .map(
          (e) => UserModel.fromSnapshot(e),
        )
        .toList());
  }

  void _createData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    String id = userCollection.doc().id;

    currentID = id;

    final newUser = UserModel(
      email: userModel.email,
      id: id,
    ).toJson();

    userCollection.doc(id).set(newUser);
  }

  void _updateData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final newData = UserModel(
      email: userModel.email,
      id: userModel.id,
    ).toJson();

    userCollection.doc(userModel.id).update(newData);
  }

  void _deleteData(String id) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    userCollection.doc(id).delete();
  }
}
