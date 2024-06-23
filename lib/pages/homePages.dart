import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");

  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini");
  final chat = GenerativeModel(
          model: "gemini-pro",
          apiKey: "AIzaSyAqa3TgDPWoGywDrm3poSg_pgtSRfCHMm0")
      .startChat(history: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(
          inputOptions: InputOptions(trailing: [
            IconButton(
                onPressed: _sendMediaMessage, icon: const Icon(Icons.image)),
          ]),
          messages: messages,
          currentUser: currentUser,
          onSend: _sendMessage),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "blabla",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "blabla",
          ),
        ],
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      //String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }
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



// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   static const apiKey = "AIzaSyAqa3TgDPWoGywDrm3poSg_pgtSRfCHMm0";
//   final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

//   TextEditingController _userInput = TextEditingController();
//   final List<Message> _messages = [];
//   Future<void> sendMessage() async {
//     final message = _userInput.text;
//     setState(() {
//       _messages
//           .add(Message(isUser: true, message: message, date: DateTime.now()));
//     });
//     final content = [Content.text(message)];
//     final response = await model.generateContent(content);
//     setState(() {
//       _messages.add(Message(
//           isUser: false, message: response.text ?? "", date: DateTime.now()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         // decoration: BoxDecoration(
//         //     image: DecorationImage(
//         //         colorFilter: new ColorFilter.mode(
//         //             Colors.black.withOpacity(0.8), BlendMode.dstATop),
//         //         image: NetworkImage(
//         //             'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEigDbiBM6I5Fx1Jbz-hj_mqL_KtAPlv9UsQwpthZIfFLjL-hvCmst09I-RbQsbVt5Z0QzYI_Xj1l8vkS8JrP6eUlgK89GJzbb_P-BwLhVP13PalBm8ga1hbW5pVx8bswNWCjqZj2XxTFvwQ__u4ytDKvfFi5I2W9MDtH3wFXxww19EVYkN8IzIDJLh_aw/s1920/space-soldier-ai-wallpaper-4k.webp'),
//         //         fit: BoxFit.cover)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Expanded(
//                 child: ListView.builder(
//                     itemCount: _messages.length,
//                     itemBuilder: (context, index) {
//                       final message = _messages[index];
//                       return Messages(
//                           isUser: message.isUser,
//                           message: message.message,
//                           date: DateFormat('HH:mm').format(message.date));
//                     })),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 15,
//                     child: TextFormField(
//                       style: TextStyle(color: Colors.white),
//                       controller: _userInput,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           label: Text('Enter Your Message')),
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//                       padding: EdgeInsets.all(12),
//                       iconSize: 30,
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.black),
//                           foregroundColor:
//                               MaterialStateProperty.all(Colors.white),
//                           shape: MaterialStateProperty.all(CircleBorder())),
//                       onPressed: () {
//                         sendMessage();
//                       },
//                       icon: Icon(Icons.send))
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Message {
//   final bool isUser;
//   final String message;
//   final DateTime date;
//   Message({required this.isUser, required this.message, required this.date});
// }

// class Messages extends StatelessWidget {
//   final bool isUser;
//   final String message;
//   final String date;
//   const Messages(
//       {super.key,
//       required this.isUser,
//       required this.message,
//       required this.date});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(15),
//       margin: EdgeInsets.symmetric(vertical: 15)
//           .copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
//       decoration: BoxDecoration(
//           color: isUser ? Colors.blueAccent : Colors.grey.shade400,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10),
//               bottomLeft: isUser ? Radius.circular(10) : Radius.zero,
//               topRight: Radius.circular(10),
//               bottomRight: isUser ? Radius.zero : Radius.circular(10))),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             message,
//             style: TextStyle(
//                 fontSize: 16, color: isUser ? Colors.white : Colors.black),
//           ),
//           Text(
//             date,
//             style: TextStyle(
//               fontSize: 10,
//               color: isUser ? Colors.white : Colors.black,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
