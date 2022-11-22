import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/pages/slectaddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'payment.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  var _value = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: const Color.fromARGB(255, 238, 238, 238),      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 30),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      )
                    ],
                    border:
                        Border.all(color: Color.fromARGB(90, 112, 112, 112)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.black,
                        iconSize: 25,
                      ),
                      const Expanded(
                        child: TextField(
                          showCursor: true,
                          autofocus: false,
                          style: TextStyle(fontSize: 20),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Area, Landmark or Apartment',
                              labelStyle: TextStyle(fontSize: 14),
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 129, 129, 129))),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 30, top: 15),
                  child: Row(
                    children: [
                      Image.asset(
                        'assests/images/gpsicn.png',
                        height: 22,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     PageRouteBuilder(
                          //         pageBuilder: (context, a, b) => BotmNav()),
                          //     (route) => false);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MYpayment()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: const Text(
                            'Use My Current Location',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 155, 55, 1)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    const Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Add address',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(0, 155, 55, 1)),
                        ))
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.3)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Stack(children: [
                        Align(
                          alignment: Alignment(-1, -1.2),
                          child: Radio(
                              value: addresses[index].value.toString(),
                              groupValue: _value,
                              onChanged: ((value) {
                                setState(() {
                                  _value = value.toString();
                                });
                              })),
                        ),
                        const Align(
                          alignment: Alignment(-.65, -.85),
                          child: Text(
                            "Add Address",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(.45, .43),
                          child: Container(
                            // color: Colors.amber,
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: ListTile(
                              title: AutoSizeText(
                                addresses[index].address.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              subtitle: AutoSizeText(
                                  'MObileno: ${addresses[index].mobileno}'),
                             
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(1, -1.2),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete,
                                  color: Colors.grey, size: 22)),
                        ),
                        Align(
                          alignment: const Alignment(.8, -1.2),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit,
                                  color: Colors.grey, size: 22)),
                        )
                        
                      ]),

                     
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}