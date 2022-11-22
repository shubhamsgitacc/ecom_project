import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mydialogue extends StatelessWidget {
  const Mydialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 90,
      color: Colors.amber,
      child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('heo')),
    );
  }
}
