import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final void Function()? onTap;
  const PostButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Icon(
            Icons.done,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
