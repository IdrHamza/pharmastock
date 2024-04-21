import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  MyButton({required this.color, required this.title, required this.onPressed});

  final Color color;
  final String title;
  final Function onPressed;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: () => widget.onPressed,
          minWidth: 200,
          height: 42,
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}