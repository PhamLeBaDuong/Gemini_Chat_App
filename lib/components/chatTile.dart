import 'package:flutter/material.dart';
import 'package:namer_app/pages/homePages.dart';

class Chattile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final void Function()? onTapDelete;

  const Chattile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 188, 187, 187),
            borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text),
            GestureDetector(onTap: onTapDelete, child: Icon(Icons.delete))
          ],
        ),
        // child: ListTile(
        //   leading: GestureDetector(
        //     onTap: onTapDelete,
        //     child: Icon(Icons.delete),
        //   ),
        //   title: GestureDetector(
        //     onTap: onTap,
        //     child: Text(text),
        //   ),
        // ),
      ),
    );
  }
}
