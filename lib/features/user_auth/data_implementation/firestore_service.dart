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
  final String? name;

  UserModel({required this.email, required this.id, required this.name});

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
        email: snapshot["email"], id: snapshot["id"], name: snapshot["name"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "id": id,
      "name": name,
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
