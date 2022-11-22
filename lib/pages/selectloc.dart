import 'package:ecommerce/pages/bottomnav.dart';
import 'package:ecommerce/pages/enterloc.dart';

import 'package:flutter/material.dart';

class Locselect extends StatefulWidget {
  const Locselect({super.key});

  @override
  State<Locselect> createState() => _LocselectState();
}

class _LocselectState extends State<Locselect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.asset(
              'assests/images/map.png',
              height: MediaQuery.of(context).size.height * 1.2,
              fit: BoxFit.fill,
            ),
          ],
        ),
      )),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            const Text(
              'Where do you want delivery?',
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 33,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 155, 55, 1)),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, a, b) => BotmNav()),
                      (route) => false);
                  // Navigator.pushAndRemoveUntil(
                  // context,
                  // PageRouteBuilder(
                  //     pageBuilder: (context, a, b) => MyOTP()),
                  // (route) => false);
                },
                child: Container(
                    // color: Colors.green,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 3.2),
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 18),
                    ))),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, b, a) => Enterloc()),
                      (route) => false);
                  // Enterloc();
                  // Home();
                },
                child: const Text(
                  'Set Location Manually',
                  style: TextStyle(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
