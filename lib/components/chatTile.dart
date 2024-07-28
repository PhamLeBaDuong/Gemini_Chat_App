import 'package:flutter/material.dart';
import 'package:namer_app/pages/homePages.dart';

class Chattile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const Chattile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Wrap(
          children: [
            const Icon(Icons.message),
            const SizedBox(
              width: 15,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
