import 'package:ecommerce/pages/otp.dart';
import 'package:ecommerce/pages/otppage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  // var int = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            height: (MediaQuery.of(context).size.height) -
                MediaQuery.of(context).padding.top,
            // color: Colors.amber,

            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height / 8),
                ),
                Image.asset(
                  'assests/images/sign.png',
                  // height: (MediaQuery.of(context).size.height) / 3.5,
                  width: (MediaQuery.of(context).size.width) -
                      ((MediaQuery.of(context).size.width) / 5),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height) / 3.2,
                  width: (MediaQuery.of(context).size.width) -
                      ((MediaQuery.of(context).size.width) / 7.5),
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: (MediaQuery.of(context).size.width) / 2.3,
                            top: (MediaQuery.of(context).size.height) / 40),
                        child: const Text(
                          'Enter Mobile Number',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        height: 42,
                        width: (MediaQuery.of(context).size.width),
                        margin:
                            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: Color.fromARGB(255, 87, 87, 87)),
                          // color: Colors.amber,
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin:const  EdgeInsets.symmetric(
                                  vertical: 4, horizontal: (15)),
                              // padding: EdgeInsets.only(right: 170),

                              child: Image.asset(
                                'assests/images/bi_phone.png',
                                height: 25,
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 4),
                              child: Image.asset(
                                'assests/images/line.png',
                                height: 28,
                              ),
                            ),
                            Expanded(
                              
                                child: TextFormField(
                                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
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
                                    pageBuilder: (context, a, b) =>
                                        MYOtpPage()),
                                (route) => false);
                            print((MediaQuery.of(context).size.height));
                          },
                          child: Container(
                              // color: Colors.green,
                              // width: (MediaQuery.of(context).size.width) - 10,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      (MediaQuery.of(context).size.width) /
                                          3.8),
                              child: const Text(
                                'Continue',
                                style: TextStyle(fontSize: 18),
                              )))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
