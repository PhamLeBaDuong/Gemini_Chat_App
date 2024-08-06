import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namer_app/pages/homePages.dart';

class Chattile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final void Function()? onTapDelete;
  final void Function()? onTapChangeTitle;
  final bool isCurrentChat;
  final DateTime dateTime;

  const Chattile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.onTapDelete,
      required this.onTapChangeTitle,
      required this.isCurrentChat,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isCurrentChat
                ? Color.fromARGB(255, 122, 196, 234)
                : Color.fromARGB(255, 221, 218, 218),
            borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: EdgeInsets.all(13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${DateTime.now().difference(dateTime).inDays} days ago",
                style: TextStyle(
                    color: Color.fromARGB(255, 130, 129, 129),
                    fontStyle: FontStyle.italic,
                    fontSize: 12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onTapDelete,
                  icon: Icon(Icons.delete),
                  color: Colors.black,
                ),
                //SizedBox(width: 25),
                IconButton(
                  onPressed: onTapChangeTitle,
                  icon: Icon(Icons.edit),
                  color: Colors.black,
                ),
                //SizedBox(width: 25),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.download),
                  color: Colors.black,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
