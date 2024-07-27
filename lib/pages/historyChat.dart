import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/features/user_auth/data_implementation/firestore_service.dart';
import 'package:namer_app/pages/homePages.dart';
import 'package:namer_app/pages/login.dart';

class HistoryChat extends StatefulWidget {
  const HistoryChat({super.key});

  @override
  State<HistoryChat> createState() => _UserprofileState();
}

class _UserprofileState extends State<HistoryChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ListView.builder(
          //     itemCount: listTitle.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(listTitle[index]),
          //       );
          //     })
        ],
      ),
    );
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

  // void _deleteChatData(String title) {
  //   final userCollection = FirebaseFirestore.instance.collection("users");

  //   final newData = UserModel(
  //     email: useremail,
  //     chatHistory:
  //   )

  //   userCollection.doc(currentID).update();
  // }
}
