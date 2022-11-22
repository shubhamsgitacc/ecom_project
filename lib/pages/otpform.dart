import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyOtpFrom extends StatefulWidget {
  const MyOtpFrom({super.key});

  @override
  State<MyOtpFrom> createState() => _MyOtpFromState();
}

class _MyOtpFromState extends State<MyOtpFrom> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        children: [
          SizedBox(
            height: 68,
            width: 64,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          )
        ],
      ),
    );
  }
}
