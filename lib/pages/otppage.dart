import 'package:ecommerce/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class MyOTP extends StatefulWidget {
  const MyOTP({super.key});

  @override
  State<MyOTP> createState() => _MyOTPState();
}

class _MyOTPState extends State<MyOTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assests/images/otp.png',
            height: 200,
            fit: BoxFit.cover,
          ),
          Container(
            height: 250,
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
            child: Column(children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              const Center(
                child: Text(
                  'Login or SignUp',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              const Text(
                'Enter 4 digit OTP sent to your mobile number',
                style: TextStyle(fontSize: 14),
              ),
              // Padding(padding: EdgeInsets.all(s0),child: OTPTextField(),),

              // Padding(
              //     padding: EdgeInsets.only(right: 1, top: 30),
              //     child: OTPTextField(
              //         otpFieldStyle: OtpFieldStyle(
              //             focusBorderColor: Color.fromARGB(1, 0, 155, 55)),
              //         // borderColor: Color(0xFF512DA8),
              //         fieldWidth: 30,
              //         // contentPadding: EdgeInsets.all(5),
              //         length: 2,
              //         // width: 10,
              //         spaceBetween: 20))

              Container(
                width: 250,
                child: Expanded(
                  child: OTPTextField(
                    outlineBorderRadius: 10,

                    otpFieldStyle:
                        OtpFieldStyle(focusBorderColor: Colors.black),
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    // fieldWidth: 10,
                    spaceBetween: 10,
                    style: TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 13),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 155, 55, 1)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, a, b) => Home()),
                        (route) => false);
                  },
                  child: Container(
                      // color: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 90),
                      child: Text('Verify'))),
              Container(
                margin: EdgeInsets.only(left: 130),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(color: Colors.black),
                    )),
              )
            ]),
          ),

          // Container(
          //   height: 200,
          //   color: Colors.amber,
          //   width: 300,
          // ),
        ]),
      ),
    );
  }
}
