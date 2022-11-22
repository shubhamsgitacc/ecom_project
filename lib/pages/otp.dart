import 'package:ecommerce/pages/home.dart';
import 'package:ecommerce/pages/otpform.dart';
import 'package:ecommerce/pages/otppage.dart';
import 'package:ecommerce/pages/selectloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:pinput/pinput.dart';

class MYOtpPage extends StatefulWidget {
  const MYOtpPage({super.key});

  @override
  State<MYOtpPage> createState() => _MYOtpPageState();
}

class _MYOtpPageState extends State<MYOtpPage> {
  @override
  final otpcontroller = TextEditingController();

  void dispose() {
    // TODO: implement dispose
    otpcontroller.dispose();
    super.dispose();
  }

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
            child: Form(
              child: Column(
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height / 8),
                  ),
                  Image.asset(
                    'assests/images/otppage.png',
                    height: (MediaQuery.of(context).size.height) / 3.5,
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height) / 2.8,
                    width: (MediaQuery.of(context).size.width) -
                        ((MediaQuery.of(context).size.width) / 7.5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 4,
                            offset: const Offset(0, 0),
                          )
                        ]),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        const Center(
                          child: Text(
                            'Verify OTP',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  ((MediaQuery.of(context).size.height) / 60)),
                          child: const Center(
                            child: Text(
                              'Enter 4 digit OTP sent to your mobile number',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        Pinput(
                          controller: otpcontroller,
                          defaultPinTheme: PinTheme(
                              height: 48,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(0, 0, 0, 0.35)),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              textStyle: const TextStyle(
                                  fontSize: 19, color: Colors.black)),
                          //                                   validator: (value) {
                          //   return value == '2222' ? null : 'Pin is incorrect';
                          // },
                        ),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Container(

                        //         height: 48,
                        //         width: 50,
                        //         decoration: BoxDecoration(
                        //             border: Border.all(color: Colors.grey),
                        //             borderRadius: BorderRadius.circular(4)),
                        //         child: TextFormField(
                        //           onSaved: (pin1) {
                        //             var a = pin1;
                        //             print(a);
                        //           },
                        //           keyboardType: TextInputType.number,
                        //           inputFormatters: [
                        //             LengthLimitingTextInputFormatter(1),
                        //             FilteringTextInputFormatter.digitsOnly
                        //           ],
                        //           onChanged: (value) {
                        //             if (value.length == 1) {
                        //               FocusScope.of(context).nextFocus();
                        //             }
                        //           },
                        //           decoration:
                        //               InputDecoration(border: InputBorder.none),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.symmetric(horizontal: 10),
                        //         height: 48,
                        //         width: 50,
                        //         decoration: BoxDecoration(
                        //             border: Border.all(color: Colors.grey),
                        //             borderRadius: BorderRadius.circular(4)),
                        //         child: TextFormField(
                        //           keyboardType: TextInputType.number,
                        //           inputFormatters: [
                        //             LengthLimitingTextInputFormatter(1),
                        //             FilteringTextInputFormatter.digitsOnly
                        //           ],
                        //           onSaved: (pin2) {},
                        //           onChanged: (value) {
                        //             if (value.length == 1) {
                        //               FocusScope.of(context).nextFocus();
                        //             }
                        //           },
                        //           decoration:
                        //               InputDecoration(border: InputBorder.none),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.symmetric(horizontal: 0),
                        //         height: 48,
                        //         width: 50,
                        //         decoration: BoxDecoration(
                        //             border: Border.all(color: Colors.grey),
                        //             borderRadius: BorderRadius.circular(4)),
                        //         child: TextFormField(
                        //           keyboardType: TextInputType.number,
                        //           decoration:
                        //               InputDecoration(border: InputBorder.none),
                        //           inputFormatters: [
                        //             LengthLimitingTextInputFormatter(1),
                        //             FilteringTextInputFormatter.digitsOnly
                        //           ],
                        //           onSaved: (pin3) {},
                        //           onChanged: (value) {
                        //             if (value.length == 1) {
                        //               FocusScope.of(context).nextFocus();
                        //             }
                        //           },
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.symmetric(horizontal: 10),
                        //         height: 48,
                        //         width: 50,
                        //         decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 color:
                        //                     Color.fromARGB(255, 161, 161, 161)),
                        //             borderRadius: BorderRadius.circular(4)),
                        //         child: TextFormField(
                        //           keyboardType: TextInputType.number,
                        //           style: const TextStyle(fontSize: 20),
                        //           inputFormatters: [
                        //             LengthLimitingTextInputFormatter(1),
                        //             FilteringTextInputFormatter.digitsOnly
                        //           ],
                        //           onSaved: (pin4) {},
                        //           onChanged: (value) {
                        //             if (value.length == 1) {
                        //               FocusScope.of(context).nextFocus();
                        //             }
                        //           },
                        //           decoration:
                        //               InputDecoration(border: InputBorder.none),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       )
                        //     ]),

                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          '2:00',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 1,
                        ),

                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(0, 155, 55, 1)),
                            onPressed: () {
                              setState(() {
                                var smsotp = ' 3333';
                                var inputotp = otpcontroller.text;
                                print(inputotp);
                                otpcontroller.clear();
                              });
                              var inputotp = otpcontroller.text;
                              // print(inputotp);
                              if (inputotp == '3333') {
                                print('scc');
                              }
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (context, a, b) =>
                                          Locselect()),
                                  (route) => false);
                              print(
                                (MediaQuery.of(context).size.height),
                              );
                            },
                            child: Container(
                                // color: Colors.green,
                                // width: (MediaQuery.of(context).size.width) - 10,
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        (MediaQuery.of(context).size.width) /
                                            3.3),
                                child: const Text(
                                  'Verify',
                                  style: TextStyle(fontSize: 18),
                                ))),
                        const SizedBox(
                          height: 5,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: InkWell(
                                  onTap: () {
                                    print('heo');
                                  },
                                  child: const Text(
                                    'Resend OTP',
                                    style: TextStyle(fontSize: 14),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
