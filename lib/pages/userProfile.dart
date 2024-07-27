import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/features/user_auth/data_implementation/firestore_service.dart';
import 'package:namer_app/pages/homePages.dart';
import 'package:namer_app/pages/login.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _createData(UserModel(email: useremail));
            },
            child: Container(
                height: 45,
                width: 125,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Create Data",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<List<UserModel>>(
              stream: _readData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text("No Data Yet"),
                  );
                }
                final users = snapshot.data;
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                      children: users != null
                          ? users.map((user) {
                              return ListTile(
                                leading: GestureDetector(
                                    onTap: () {
                                      _deleteData(currentID);
                                    },
                                    child: Icon(Icons.delete)),
                                trailing: GestureDetector(
                                  onTap: () {
                                    _updateData(UserModel(email: user.email));
                                  },
                                  child: Icon(Icons.update),
                                ),
                                //subtitle: Text(user.chatHistory![0][0].toString()),
                                title: GestureDetector(
                                    onTap: () {}, child: Text(title)),
                              );
                            }).toList()
                          : []),
                );
              }),
          Center(
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (content) => LoginPage()),
                    (route) => false);
              },
              child: Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ),
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