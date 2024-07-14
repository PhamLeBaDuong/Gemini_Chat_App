import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
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
    try {
      //String question = chatMessage.text;
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
}
