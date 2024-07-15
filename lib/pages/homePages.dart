import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namer_app/pages/chatPage.dart';
import 'package:namer_app/pages/userProfile.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';

String currentID = "";
String useremail = "";
String title = "";
Map<String, List<Map<String, DateTime>>> chatMessages = {};
List<ChatMessage> messages = [];
// List<Content> chatHistory = List<Content>.from(messages);
ChatUser currentUser = ChatUser(id: "0", firstName: "User");

ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini");
final chat = GenerativeModel(
        model: "gemini-pro", apiKey: "AIzaSyAqa3TgDPWoGywDrm3poSg_pgtSRfCHMm0")
    .startChat(history: []);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => GNav(
          selectedIndex: controller.selectedIndex.value,
          onTabChange: (index) {
            controller.selectedIndex.value = index;
          },
          padding: EdgeInsets.all(16),
          gap: 8,
          tabs: const [
            GButton(
              icon: Icons.message,
              text: "Home",
            ),
            GButton(
              icon: Icons.group_work,
              text: "History",
            ),
            GButton(
              icon: Icons.account_box,
              text: "Account",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const Chatpage(),
    Container(color: Colors.purple),
    const Userprofile()
  ];
}
