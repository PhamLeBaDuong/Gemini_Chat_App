import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class UserModel {
  final String? email;
  final Map<String, List<Map<String, DateTime>>>? chatHistory;
  final String? id;

  UserModel({this.email, this.chatHistory, this.id});

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
        email: snapshot["email"], chatHistory: snapshot["chatHistory"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "chatHistory": chatHistory,
      "id": id,
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
    chatHistory: userModel.chatHistory,
  ).toJson();

  userCollection.doc(id).set(newUser);
}

void _updateData(UserModel userModel) {
  final userCollection = FirebaseFirestore.instance.collection("users");

  final newData = UserModel(
    email: userModel.email,
    chatHistory: userModel.chatHistory,
  ).toJson();

  userCollection.doc(userModel.email).update(newData);
}

void _deleteData(String id) {
  final userCollection = FirebaseFirestore.instance.collection("users");

  userCollection.doc(id).delete();
}
