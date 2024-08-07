import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/components/menu_item.dart';
import 'package:namer_app/components/menu_items.dart';
import 'package:namer_app/components/settingTile.dart';
import 'package:namer_app/components/text_box.dart';
import 'package:namer_app/features/user_auth/data_implementation/firestore_service.dart';
import 'package:namer_app/global/common/toast.dart';
import 'package:namer_app/pages/homePages.dart';
import 'package:namer_app/pages/login.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  @override
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text(
                "Edit $field",
                style: TextStyle(color: Colors.white),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Enter new $field",
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
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentID)
          .update({field: newValue});
      userName = newValue;
    }
  }

  Future<void> deleteChatMemory() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text(
                "Comfirm deleting entire chat history?",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () async {
                      var temp = FirebaseFirestore.instance
                          .collection("users")
                          .doc(currentID)
                          .collection("chatrooms");
                      var tempp = await temp.get();
                      for (var doc in tempp.docs) {
                        await doc.reference.delete();
                      }
                      messages = [];
                      title = "";
                      chatID = "";
                      geminiChatHistory = [];
                      Navigator.of(context).pop(context);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
  }

  Widget build(BuildContext context) {
    PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
        value: item,
        child: Row(
          children: [
            Icon(item.icon),
            SizedBox(
              width: 10,
            ),
            Text(item.text),
          ],
        ));
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<MenuItem>(
                iconColor: Colors.white,
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) =>
                    [...MenuItems.items.map(buildItem).toList()])
          ],
          title: Text(
            "Profile Page",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 30, 30, 30),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(currentID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Icon(
                    Icons.person,
                    size: 72,
                  ),
                  Text(
                    useremail,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      "My Details",
                      style:
                          TextStyle(color: Color.fromARGB(255, 130, 129, 129)),
                    ),
                  ),
                  MyTextBox(
                      onPressed: () => editField('name'),
                      text: userData["name"],
                      sectionName: "username"),
                  SizedBox(
                    height: 25,
                  ),
                  ExpansionTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            color: Color.fromARGB(255, 130, 129, 129),
                            fontSize: 15),
                      ),
                    ),
                    children: [
                      Settingtile(
                        tileName: "Memory",
                        onPressed: deleteChatMemory,
                        buttonName: "Clear Gemini's memory",
                        isVital: true,
                      )
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error${snapshot.error}"),
              );
            }
            return const CircularProgressIndicator();
          },
        ));
  }

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemSignOut:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
        showToast(message: "User is signed out");
        break;
    }
  }
}
