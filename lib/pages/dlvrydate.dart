import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/pages/bottomnav.dart';
import 'package:ecommerce/pages/home.dart';
import 'package:ecommerce/pages/slectaddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Setdlvr extends StatefulWidget {
  const Setdlvr({super.key});

  @override
  State<Setdlvr> createState() => _SetdlvrState();
}

class _SetdlvrState extends State<Setdlvr> {
  bool isactive=false;
  List days = ['mon', 'tue', 'wed', 'thu', 'fur', 'sat', 'sun'];
  List time = [
    '1:00 pm',
    '2:00 pm',
    '3:00 pm',
    '4:00 pm',
    '6:00 pm',
    '7:00 pm',
    '8:00 pm',
    '9:00 pm'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(1000, 238, 238, 238),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                color: Colors.white,
                child: Container(
                  // margin: EdgeInsets.only(
                  //         top: MediaQuery.of(context).padding.top) /
                  //     4,
                  height: 50,
                  // color: Colors.amber,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    bottom: 3,
                                    left: ((1 / 100) *
                                        MediaQuery.of(context).size.width),
                                    right: ((1 / 100) *
                                        MediaQuery.of(context).size.width)),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Navigator.pushAndRemoveUntil(
                                    //     context,
                                    //     PageRouteBuilder(
                                    //         pageBuilder: (context, a, b) =>
                                    //             BotmNav()),
                                    //     (route) => false);
                                  },
                                  icon: const Icon(
                                    IconData(
                                      0xe793,
                                      fontFamily: 'MaterialIcons',
                                      matchTextDirection: true,
                                    ),
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                )),
                            const Text(
                              'Categories',
                              style:
                                  TextStyle(fontSize: 23, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: ((5 / 100) *
                                      MediaQuery.of(context).size.width)),
                              child: InkWell(
                                onTap: () {
                                  print((5 / 100) *
                                      MediaQuery.of(context).size.width);
                                },
                                child: Image.asset(
                                  'assests/images/carticn.png',
                                  height: 20,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 3,
                                  left: ((5 / 100) *
                                      MediaQuery.of(context).size.width),
                                  right: ((5 / 100) *
                                      MediaQuery.of(context).size.width)),
                              child: Image.asset(
                                'assests/images/bellicn.png',
                                height: 30,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                height: 133,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(3, 3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  children: [
                    // const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Text(
                            'Delivery Address',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 13),
                          width: MediaQuery.of(context).size.width / 1.70,
                          // height: 50,
                          // color: Colors.amber,
                          child: const AutoSizeText(
                            "Shop No.5, A/29, Bhatt Building, Old Nagardas Road,"
                            "Andheri (west), Mumbai-400059",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 110, 110, 110)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: TextButton(
                              onPressed: (() {}),
                              child: const Text(
                                'Change',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(0, 155, 55, 1)),
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 5),
                          child: Text(
                            'Mobile Number: +91 7854779368',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 110, 110, 110)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Container(
                height: 320,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(3, 3),
                      )
                    ],
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 5),
                          child: Text(
                            'Delivery Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 13, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'March',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              RotatedBox(
                                quarterTurns: 3,
                                child: IconButton(
                                  icon: const Icon(
                                    IconData(
                                      0xf570,
                                      fontFamily: 'MaterialIcons',
                                    ),
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: (() {}),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: days.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 50,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: isactive==false? Color.fromARGB(218, 201, 201, 201) : Colors.green,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: Text(
                                        days[index],
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            'Delivery Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: time.length,
                          itemBuilder: ((context, index) {
                            return Container(
                                margin: EdgeInsets.symmetric(horizontal: 7),
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Color.fromARGB(100, 0, 0, 0))),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      time[index],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(100, 0, 0, 0)),
                                    ),
                                  ),
                                ));
                          })),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(
              //     top: MediaQuery.of(context).size.height / 6 -
              //         MediaQuery.of(context).padding.top / 2,
              //   ),
              //   height: MediaQuery.of(context).size.height / 6,
              //   color: Colors.white,
              //   width: MediaQuery.of(context).size.width,
              //   child: Column(children: [
              //     const SizedBox(height: 15),
              //     ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //             backgroundColor: Color.fromRGBO(0, 155, 55, 1)),
              //         onPressed: () {
              //           Navigator.pushAndRemoveUntil(
              //               context,
              //               PageRouteBuilder(
              //                   pageBuilder: (context, a, b) => Setdlvr()),
              //               (route) => false);
              //           // Navigator.pushAndRemoveUntil(
              //           // context,
              //           // PageRouteBuilder(
              //           //     pageBuilder: (context, a, b) => MyOTP()),
              //           // (route) => false);
              //         },
              //         child: Container(

              //             // color: Colors.green,
              //             padding: EdgeInsets.symmetric(
              //                 horizontal:
              //                     MediaQuery.of(context).size.width / 5),
              //             child: const Text(
              //               'Proceed to Payment',
              //               style: TextStyle(fontSize: 18),
              //             ))),
              //   ]),
              // )
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: MediaQuery.of(context).size.height / 8,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0, 155, 55, 1)),
                    onPressed: () {
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     PageRouteBuilder(
                      //         pageBuilder: (context, a, b) => Selectaddress()),
                      //     (route) => false);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Selectaddress();
                        },
                      ));
                    },
                    child: SizedBox(

                        // color: Colors.green,
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 40,
                        child: const Center(
                          child: Text(
                            'Proceed to Payment',
                            style: TextStyle(fontSize: 18),
                          ),
                        )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

cont(double he, double wi, Color clr, var data) {
  return Container(
    margin: EdgeInsets.all(5),
    height: he,
    color: clr,
    width: wi,
    child: Center(child: Text(data)),
  );
}
