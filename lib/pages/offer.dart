import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MYOfferPage extends StatefulWidget {
  const MYOfferPage({super.key});

  @override
  State<MYOfferPage> createState() => _MYOfferPageState();
}

class _MYOfferPageState extends State<MYOfferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.green,
              )),
          title: const Text(
            'Deals',
            style: TextStyle(color: Colors.green),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  // height: double.infinity,
                  child: GridView.builder(
                      itemCount: cpndata.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2 / 2.5,
                          crossAxisCount: 2,
                          crossAxisSpacing:
                              MediaQuery.of(context).size.width * 0.03,
                          mainAxisSpacing:
                              MediaQuery.of(context).size.width * 0.03),
                      itemBuilder: ((context, index) {
                        return Container(
                          // rgba(71, 204, 118, 0.79)
                          decoration: BoxDecoration(
                              // rgba(70, 251, 135, 0.6)
                              color: const Color.fromRGBO(70, 251, 135, 0.6),
                              borderRadius: BorderRadius.circular(6)),
                          child: Stack(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  cpnDiaoge(
                                      context,
                                      cpndata[index].des.toString(),
                                      cpndata[index].code.toString(),
                                      cpndata[index].headin.toString(),
                                      cpndata[index].finaldesc.toString());
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        top: MediaQuery.of(context).size.width *
                                            0.05,
                                        right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(cpndata[index].headin.toString()),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          // color: Colors.amber,
                                          constraints: BoxConstraints(
                                              maxHeight: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              minHeight: 0),
                                          child: AutoSizeText(
                                            cpndata[index].des.toString(),
                                            style: const TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              const Align(
                                  alignment: Alignment(-0.50, .5),
                                  child: Text('tap to copy code')),
                              Align(
                                alignment: const Alignment(0, .9),
                                child: DottedBorder(
                                  color: const Color.fromARGB(255, 16, 128, 20),
                                  strokeWidth: 1,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(6),
                                  dashPattern: [8, 4],
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      height: 25,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      // color: Colors.green,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                      ),

                                      child: Center(
                                          child: Text(
                                        cpndata[index].code.toString(),
                                        style: const TextStyle(
                                            color: Colors.green),
                                      )),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ));
  }
}

class Cpndata {
  String? headin, des, code, finaldesc;
  Cpndata({this.headin, this.des, this.code, this.finaldesc});
}

List<Cpndata> cpndata = [
  Cpndata(
      headin: 'For New Users',
      des: 'Flat 50% of upto ₹100 on First Order',
      code: 'FUN40',
      finaldesc:
          'This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.'),
  Cpndata(
      headin: 'For All Users',
      des: 'Get Free delivery on every order',
      code: 'FREEDEL',
      finaldesc:
          'This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.'),
  Cpndata(
      headin: 'For New Users',
      des: 'Flat 40% of upto ₹800 on First Order',
      code: 'FREELIGHT',
      finaldesc:
          'This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.'),
  Cpndata(
      headin: 'For All Users',
      des: 'Get free juice',
      code: 'PIZZA40',
      finaldesc:
          'This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.'),
  Cpndata(
      headin: 'For New Users',
      des: 'Flat 50% of upto ₹100 on First Order',
      code: 'FUN40',
      finaldesc:
          'This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.This goanna be final desc.'),
];

 cpnDiaoge( BuildContext context, String desc, code, heading, finaldesc) {
  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0))),
          title: Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 60, minHeight: 0),
                width: MediaQuery.of(context).size.width / 1.3,
                height: 30,
                // color: Colors.amber,
                child: AutoSizeText(
                  heading,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width / 1.3,
                child: Text(
                  desc,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width / 1.3,
                child: Text(
                  finaldesc,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
             Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width / 1.3,
                 child :const  Text(
                'Tap to copy code',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              ),


              DottedBorder(
                color: const Color.fromARGB(255, 16, 128, 20),
                strokeWidth: 1,
                borderType: BorderType.RRect,
                radius: const Radius.circular(6),
                dashPattern: [8, 4],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width / 3,
                    // color: Colors.green,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),

                    child: Center(
                        child: Text(
                      code,
                      style: const TextStyle(fontSize: 16, color: Colors.green),
                    )),
                  ),
                ),
              ),
              
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 10),
              //   width: MediaQuery.of(context).size.width/1.3,

              //   child: Text(finaldesc,style: TextStyle(fontSize: 17),),
              // ),

              // Image.asset(
              //   succ==true?
              //   'assests/images/successdia.png': 'assests/images/errdia.png'),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5, bottom: 10),
              //   child: Text(
              //       succ == true ? 'Order Successful' : 'Order Unsuccessful',
              //       style: const TextStyle(fontSize: 23, color: Colors.black)),
              // ),
              // Text(
              //   succ == true
              //       ? 'Your order id is #345345 successfully placed'
              //       : 'Order placement failed due to '
              //           'payment failure',
              //   style: const TextStyle(fontSize: 15, color: Colors.black),
              //   textAlign: TextAlign.center,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10),
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: Text(
              //       succ==true?
              //       'Track Order': 'Retry Payment',
              //       style: const TextStyle(fontSize: 18),
              //     ),
              //   ),
              // ),
              // TextButton(
              //     onPressed: () {
              //       succ==true?
              //       Navigator.pop(context) : Navigator.push(context, MaterialPageRoute(builder: (context){return BotmNav();}));
              //     },
              //     child:Text( succ==true? 'Go Back': 'Go To Home', style: TextStyle(fontSize: 18)))
            ],
          ),
        );
      }));
}
