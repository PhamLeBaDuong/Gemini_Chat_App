import 'dart:core';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class UserModel {
  final String? email;
  // final Map<String, List<Map<String, DateTime>>>? chatHistory;
  //final List<List<Map<String, DateTime>>>? chatHistory;
  //final List<String>? listTitle;
  final String? id;

  UserModel({this.email, this.id});

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(email: snapshot["email"], id: snapshot["id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "id": id,
    };
  }
}

class Message {
  final Timestamp? timestamp;
  final String? message;

  Message({this.message, this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'message': message,
    };
  }
}

class ChatRoom {
  final String? title;
  final String? chatID;
  final Timestamp? timestamp;

  ChatRoom({this.title, this.chatID, this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'chatID': chatID,
      'timestamp': timestamp,
    };
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

  final newUser = UserModel(
    email: userModel.email,
    // chatHistory: userModel.chatHistory,
    // listTitle: userModel.listTitle,
  ).toJson();

  userCollection.doc(id).set(newUser);
}

void _updateData(UserModel userModel) {
  final userCollection = FirebaseFirestore.instance.collection("users");

  final newData = UserModel(
    email: userModel.email,
    // chatHistory: userModel.chatHistory,
    // listTitle: userModel.listTitle,
  ).toJson();

  userCollection.doc(userModel.id).update(newData);
}

void _deleteData(String id) {
  final userCollection = FirebaseFirestore.instance.collection("users");

  userCollection.doc(id).delete();
}
