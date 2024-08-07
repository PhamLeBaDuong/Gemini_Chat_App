import 'package:flutter/material.dart';

class Settingtile extends StatelessWidget {
  final String tileName;
  final String buttonName;
  final void Function()? onPressed;
  final bool isVital;
  const Settingtile(
      {super.key,
      required this.tileName,
      required this.onPressed,
      required this.buttonName,
      required this.isVital});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 221, 218, 218),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left: 15, bottom: 0),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tileName,
                style: TextStyle(color: Colors.black),
              ),
              TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 250, 74, 62)),
                child: Text(
                  buttonName,
                  style: TextStyle(color: Colors.white),
                ),
              )
              // IconButton(
              //     onPressed: onPressed,
              //     icon: Icon(
              //       Icons.settings,
              //       color: Color.fromARGB(255, 130, 129, 129),
              //     ))
            ],
          ),
        ],
      ),
    );
  }
}
