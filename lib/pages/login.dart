import 'package:ecommerce/pages/otppage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 150),
              child: Image.asset(
                'assests/images/Signup.png',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 220,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 4),
                    )
                  ]),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  const Center(
                    child: Text(
                      'Login or SignUp',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 140, top: 15),
                    child: const Text(
                      'Enter Mobile Number',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    height: 42,
                    width: 250,
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey),
                      // color: Colors.amber,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                          // padding: EdgeInsets.only(right: 170),

                          child: Image.asset(
                            'assests/images/mobile.png',
                            height: 25,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Image.asset(
                            'assests/images/line2.png',
                            height: 28,
                          ),
                        ),
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15)),
                        ))
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(0, 155, 55, 1)),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (context, a, b) => MyOTP()),
                            (route) => false);
                      },
                      child: Container(
                          // color: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 90),
                          child: Text('Continue')))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
