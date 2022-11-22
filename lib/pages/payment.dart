import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MYpayment extends StatefulWidget {
  const MYpayment({super.key});

  @override
  State<MYpayment> createState() => _MYpaymentState();
}

class _MYpaymentState extends State<MYpayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(0, 155, 55, 1),
          ),
        ),
        title: const Text(
          'Payment Options',
          style: TextStyle(
            color: Color.fromRGBO(0, 155, 55, 1),
          ),
        ),
        titleSpacing: 0,
      ),
      backgroundColor: Color.fromARGB(1000, 238, 238, 238),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
